class Api::V1::Current::ArticlesController < Api::V1::BaseApiController
  def index
    # binding.pry
    articles = Article.where(user: current_user, state: 1).order(updated_at: :DESC)
    # binding.pry

    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end
end
