class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    following.save
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
