class UsersController < ApplicationController
  before_action :set_user, only: [:show, :likes]
  def show
    @nickname = @user.nickname
    @reviews = @user.reviews
    @followings = @user.relationships.where(user_id: @user.id)
    @followers = @user.reverse_of_relationships.where(follow_id: @user.id)
  end

  def likes
    @likes = @user.likes.includes(:review)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
