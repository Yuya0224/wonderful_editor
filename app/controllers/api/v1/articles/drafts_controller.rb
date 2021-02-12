class Api::V1::Articles::DraftsController < Api::V1::BaseApiController
  def index
    # binding.pry
    articles = current_user.articles.draft.order(updated_at: :DESC)
    # binding.pry

    render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
  end

  def show
    # binding.pry

    article = current_user.articles.draft.find(params[:id])
    render json: article, each_serializer: Api::V1::ArticleSerializer
  end
end
