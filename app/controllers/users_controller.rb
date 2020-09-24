class UsersController < ApplicationController
  before_action :set_user, only: [:show, :likes]
  def show
    @nickname = @user.nickname
    @reviews = @user.reviews
  end

  def likes
    @likes = @user.likes.includes(:review)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
