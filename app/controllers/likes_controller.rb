class LikesController < ApplicationController
  def index
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    authorize like
    if like.save
      flash[:notice] = "Like was saved."
      redirect_to :back
    else
      flash[:alert] = "There was an error saving the like. Please try again."
      redirect_to :back
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    authorize like
    if like.destroy
      flash[:notice] = "Like was deleted."
      redirect_to :back
    else
      flash[:alert] = "There was an error deleting the like. Please try again."
      redirect_to :back
    end
  end
end
