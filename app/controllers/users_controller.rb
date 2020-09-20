class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @reviews = current_user.reviews
  end
end
