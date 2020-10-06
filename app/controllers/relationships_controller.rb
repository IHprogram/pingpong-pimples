class RelationshipsController < ApplicationController
  before_action :set_user

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
