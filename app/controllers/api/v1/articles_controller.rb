module Api::V1
 class ArticlesController < BaseApiController
  # before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    articles = Article.order(updated_at: :DESC)

    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end
 end
end
