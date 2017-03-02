class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    find_or_create_user

    find_or_create_topic

    @bookmark = @topic.bookmarks.create(url: params["body-plain"])
    @bookmark.user = @user

    head 200
  end

  private

  def find_or_create_user
    @user = User.find_by(email: params[:sender])

    if @user.nil?
      @user = User.new(email: params[:sender], password: "password", password_confirmation: "password")
      @user.save
    end
  end

  def find_or_create_topic
    @topic = Topic.find_by(title: params[:subject])

    if @topic.nil?
      @topic = Topic.new(title: params[:subject])
      @topic.save
    end
  end

end
