require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }
    # let(:login_user) { create(:user)}
    # let(:params) { FactoryBot.attributes_for(:user, email: login_user.email, password: login_user.password)}

    context "登録されているユーザーが存在しているとき" do
      let(:params) { FactoryBot.attributes_for(:user, email: login_user.email, password: login_user.password) }
      let(:login_user) { create(:user) }

      # let(:params) { FactoryBot.attributes_for(:user, email: login_user.email, password: login_user.password)}

      it "ログインできる" do
        subject
        # binding.pry

        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to
        expect(response).to have_http_status(:ok)
      end
    end

    context "登録されているユーザーとemailが異なるとき" do
      let(:params) { FactoryBot.attributes_for(:user, email: "yuya@example.com", password: login_user.password) }
      let(:login_user) { create(:user) }

      # let(:params) { FactoryBot.attributes_for(:user, email: login_user.email, password: login_user.password)}

      it "ログインできない" do
        subject
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "Invalid login credentials. Please try again."

        header = response.header
        expect(header["access-token"]).not_to be_present
        expect(header["client"]).not_to be_present
      end
    end

    context "登録されているユーザーとpasswordが異なるとき" do
      let(:params) { FactoryBot.attributes_for(:user, email: login_user.email, password: "yuyayuya") }
      let(:login_user) { create(:user) }

      # let(:params) { FactoryBot.attributes_for(:user, email: login_user.email, password: login_user.password)}

      it "ログインできない" do
        subject
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "Invalid login credentials. Please try again."

        header = response.header
        expect(header["access-token"]).not_to be_present
        expect(header["client"]).not_to be_present
      end
    end
  end
end
