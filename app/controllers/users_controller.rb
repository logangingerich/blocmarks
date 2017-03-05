class UsersController < ApplicationController
  def show
    @user_bookmarks = Bookmark.where(user_id: current_user.id)
    @liked_bookmarks = Like.where(user_id: current_user.id)
  end
end
