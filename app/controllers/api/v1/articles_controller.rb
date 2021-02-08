class Api::V1::ArticlesController < Api::V1::BaseApiController
  # before_action :set_article, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # GET /articles
  def index
    articles = Article.order(updated_at: :DESC)

    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article, each_serializer: Api::V1::ArticleSerializer
  end

  def create
    article = current_user.articles.create!(article_params)
    # binding.pry

    # 上記は下でも書き換え可能
    # article = Article.create!(article_params, user_id: current_user.id])

    render json: article, serializer: Api::V1::ArticleSerializer
  end

  def update
    article = current_user.articles.find(params[:id])
    # binding.pry
    article.update!(article_params)
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  def destroy
    article = current_user.articles.find(params[:id])
    # binding.pry
    article.destroy!
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  private

    def article_params
      # binding.pry
      params.require(:article).permit(:body, :title)
    end
end
