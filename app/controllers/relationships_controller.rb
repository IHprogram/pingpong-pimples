class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    @following = current_user.follow(@user)
    @following.save
    @followers_number = @user.reverse_of_relationships.where(follow_id: @user.id).length
    @user = User.find(params[:follow_id])
    @follower = current_user.follow(@user)
  end

  def destroy
    @following = current_user.unfollow(@user)
    @following.destroy
    @followers_number = @user.reverse_of_relationships.where(follow_id: @user.id).length
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
