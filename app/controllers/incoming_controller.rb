class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Find the user by using params[:sender]
    @user = User.find_by(email: params[:sender])
    # Find the topic by using params[:subject]
    @topic = Topic.find_by(title: params[:subject])
    # Assign the url to a variable after retreiving it from params["body-plain"]
    @url = @topic.bookmarks.find_by(url: params["body-plain"])
    # Check if user is nil, if so, create and save a new user
    if @user.nil?
      @user = User.create!(email: params[:sender], password: "password", password_confirmation: "password")
    end
    # Check if the topic is nil, if so, create and save a new topic
    if @topic.nil?
      @topic = Topic.create!(title: params[:subject])
    end
    # Now that you're sure you have a valid user and topic, build and save a new bookmark
    # Assuming all went well.
    @bookmark = @topic.bookmarks.new(url: @url)
    @bookmark.save
    head 200
  end
end
