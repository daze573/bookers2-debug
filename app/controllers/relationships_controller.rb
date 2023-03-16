class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_to about_path
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to about_path
  end

  def followings
    user = user.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
