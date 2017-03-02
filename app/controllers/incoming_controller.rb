class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    # Find the user by using params[:sender]
    @user = User.find_by(email: params[:sender])
    # Find the topic by using params[:subject]
    @topic = Topic.find_by(title: params[:subject])

    if @topic.nil?
      @topic = Topic.new(title: params[:subject])
    end
    
    @topic.save
    # Assign the url to a variable after retreiving it from params["body-plain"]
    @url = @topic.bookmarks.find_by(url: params["body-plain"])
    # Check if user is nil, if so, create and save a new user
    if @user.nil?
      @user = User.new(email: params[:sender], password: "password", password_confirmation: "password")
      @user.save
    end

    @topic.save

    @bookmark = @topic.bookmarks.new(url: @url)
    @bookmark.save
    head 200
  end
end
