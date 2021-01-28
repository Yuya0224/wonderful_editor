class ArticleLikesController < ApplicationController
  before_action :set_article_like, only: [:show, :update, :destroy]

  # GET /article_likes
  def index
    @article_likes = ArticleLike.all

    render json: @article_likes
  end

  # GET /article_likes/1
  def show
    render json: @article_like
  end

  # POST /article_likes
  def create
    @article_like = ArticleLike.new(article_like_params)

    if @article_like.save
      render json: @article_like, status: :created, location: @article_like
    else
      render json: @article_like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /article_likes/1
  def update
    if @article_like.update(article_like_params)
      render json: @article_like
    else
      render json: @article_like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /article_likes/1
  def destroy
    @article_like.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_like
      @article_like = ArticleLike.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_like_params
      params.fetch(:article_like, {})
    end
end
