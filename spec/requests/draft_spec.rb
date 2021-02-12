require "rails_helper"

RSpec.describe "Drafts", type: :request do
  describe "GET /api/v1/articles/drafts" do
    subject { get(api_v1_articles_drafts_path, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    let!(:article1) { create(:article, updated_at: 1.days.ago, state: 0, user: current_user) }
    let!(:article2) { create(:article, updated_at: 2.days.ago, state: 1, user: current_user) }
    let!(:article3) { create(:article, updated_at: 3.days.ago, state: 1, user: other_user) }
    let!(:article4) { create(:article, updated_at: 4.days.ago, state: 0, user: current_user) }
    let!(:article5) { create(:article, updated_at: 5.days.ago, state: 1, user: other_user) }
    let!(:article6) { create(:article, updated_at: 6.days.ago, state: 0, user: current_user) }

    # before { create_list(:article, 3)}
    it "公開しているとき、更新順に記事を取得できる" do
      # subject
      # binding.pry
      res = JSON.parse(response.body)
      # binding.pry
      expect(res.length).to eq 3
      # binding.pry

      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      # # binding.pry

      expect(res.map {|d| d["id"] }).to eq [article1.id, article4.id, article6.id]

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/articles/draft/:id" do
    subject { get(api_v1_articles_draft_path(article_id), headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context "指定した記事のidが存在している" do
      let(:article_id) { article.id }

      context "下書き状態" do
        let(:article) { create(:article, state: 0, user: current_user) }

        it "指定したidの詳細な記事を取得できる" do
          # subject
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

      context "公開していないとき" do
        let(:article) { create(:article, state: 0) }

        it "記事を取得できない" do
          expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
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
end
