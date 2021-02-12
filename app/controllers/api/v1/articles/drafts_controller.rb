class Api::V1::Articles::DraftsController < Api::V1::BaseApiController
  def index
    # binding.pry
    articles = Article.where(user: current_user, state: 0).order(updated_at: :DESC)
    # binding.pry

    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    # binding.pry

    article = Article.where(user: current_user, state: 0).find(params[:id])
    render json: article, each_serializer: Api::V1::ArticleSerializer
  end
end
