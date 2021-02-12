require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET /api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:other_user) { create(:user) }

    let!(:article1) { create(:article, updated_at: 1.days.ago, state: 0, user: current_user) }
    let!(:article2) { create(:article, updated_at: 2.days.ago, state: 1, user: current_user) }
    let!(:article3) { create(:article, updated_at: 3.days.ago, state: 1, user: other_user) }
    let!(:article4) { create(:article, updated_at: 4.days.ago, state: 0, user: current_user) }
    let!(:article5) { create(:article, updated_at: 5.days.ago, state: 1, user: other_user) }
    let!(:article6) { create(:article, updated_at: 6.days.ago, state: 1, user: current_user) }

    # before { create_list(:article, 3)}
    it "公開しているとき、更新順に記事を取得できる" do
      subject
      # binding.pry
      res = JSON.parse(response.body)
      # binding.pry
      expect(res.length).to eq 2
      # binding.pry

      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      # # binding.pry

      expect(res.map {|d| d["id"] }).to eq [article2.id, article6.id]

      expect(response).to have_http_status(:ok)
    end
  end
end
