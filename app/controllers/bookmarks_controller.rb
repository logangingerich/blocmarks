class BookmarksController < ApplicationController
  require 'embedly'
  require 'json'

  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    embedly_api = Embedly::API.new :key => '950f69d87fee4bd18b41563cda5fff74'
    obj = embedly_api.extract :url => @bookmark.url
    @image_thumb = obj.first.favicon_url
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new
    @bookmark.url = params[:bookmark][:url]
    @bookmark.user = current_user

    if @bookmark.save
      flash[:notice] = "Bookmark saved successfully."
      redirect_to @topic
    else
      flash[:alert] = "Bookmark failed to save."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.url = params[:bookmark][:url]
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "Bookmark was successfully deleted."
      redirect_to @topic
    else
      flash[:alert] = "There was an error deleting the bookmark. Please try again."
      redirect_to [@bookmark.topic, @bookmark]
    end
  end
end
