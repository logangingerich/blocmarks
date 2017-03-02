class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    # Find the user by using params[:sender]
    @user = User.find_by(email: params[:sender])

    if @user.nil?
      @user = User.new(email: params[:sender], password: "password", password_confirmation: "password")
      @user.save
    end
    # Find the topic by using params[:subject]
    @topic = Topic.find_by(title: params[:subject])

    if @topic.nil?
      @topic = Topic.new(title: params[:subject])
      @topic.save
    end

    # Assign the url to a variable after retreiving it from params["body-plain"]
    @topic.bookmarks.create(url: params["body-plain"])
    @bookmark.user = current_user

    head 200
  end
end
