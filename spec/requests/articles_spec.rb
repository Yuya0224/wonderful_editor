require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, updated_at: 3.days.ago) }
    let!(:article3) { create(:article, updated_at: 2.days.ago) }

    # before { create_list(:article, 3)}
    it "更新順に記事を取得できる" do
      subject
      # binding.pry
      res = JSON.parse(response.body)
      # binding.pry
      expect(res.length).to eq 3
      # binding.pry

      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      # # binding.pry

      expect(res.map {|d| d["id"] }).to eq [article1.id, article3.id, article2.id]

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した記事のidが存在した場合" do
      let(:article_id) { article.id }
      let(:article) { create(:article) }

      it "指定したidの詳細な記事を取得できる" do
        subject
        # binding.pry
        res = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
        expect(res["user"]["id"]).to eq article.user.id
        expect(res["user"].keys).to eq ["id", "name", "email"]
      end
    end

    context "存在しない場合" do
      let(:article_id) { 10000 }

      it "記事が見つからない" do
        # binding.pry
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe  "POST /api/v1/articles" do
    # binding.pry
    subject { post(api_v1_articles_path, params: params) }

    context "適切なパラメータを送信したとき" do
      let(:params) { { article: FactoryBot.attributes_for(:article) } }
      let(:current_user) { create(:user) }
      it "記事のレコードが作成できる" do
        # binding.pry
        allow_any_instance_of(Api::V1::BaseApiController).to receive(:dummy).and_return(current_user)
        expect { subject }.to change { Article.where(user_id: current_user.id).count }.by(1)
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
