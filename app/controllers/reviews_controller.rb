class ReviewsController < ApplicationController
  before_action :exist_review?, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :search_review, only: [:index, :search]

  def index
    @reviews = Review.all.order('created_at DESC').page(params[:page]).per(6)
    set_review_column
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
    @comment = Comment.new
    @comments = @review.comments.includes(:user).order('created_at DESC').page(params[:page]).per(10)
    @like_count = Like.where("review_id = #{@review.id}")
    @comments_count = Comment.where("review_id = #{@review.id}").length
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to review_path(@review.id)
    else
      render :edit
    end
  end

  def destroy
    render :show unless @review.destroy
  end

  def search
    @results = @search.result
  end

  private

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def review_params
    params.require(:review).permit(:name, :manufacture_id, :type_id, :spin_id, :speed_id, :control_id, :hardness_id, :price, :evaluation_id, :content, :image, :video).merge(user_id: current_user.id)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def search_review
    @search = Review.ransack(params[:q])
  end

  def set_review_column
    @review_manufacture = Review.select('manufacture_id').distinct
    @review_type = Review.select('type_id').distinct
  end

  def exist_review?
    #  データベースに存在しないIDがURLに入力された場合、トップページに遷移する。
    redirect_to root_path unless Review.find_by(id: params[:id])
  end
end
