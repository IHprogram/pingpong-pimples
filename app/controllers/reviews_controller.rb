class ReviewsController < ApplicationController
  before_action :set_review, only: [:show]
  def index
    @reviews = Review.all.order('created_at DESC')
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def review_params
    params.require(:review).permit(:name, :manufacture_id, :type_id, :hardness, :spin_id, :speed_id, :price, :level_id, :evaluation_id, :content, :image).merge(user_id: current_user.id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
