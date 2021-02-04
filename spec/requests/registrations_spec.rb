require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "適切なパラメータを送信したとき" do
      let(:params) { FactoryBot.attributes_for(:user) }

      it "ユーザーが新規登録される" do
        expect { subject }.to change { User.count }.by(1)
        # binding.pry

        res = JSON.parse(response.body)
        expect(res["data"]["name"]).to eq params[:name]
        expect(res["data"]["email"]).to eq params[:email]
        expect(res["data"]["password"]).to eq params[:password]

        # binding.pry

        expect(headers["access-token"]).to be_present
        expect(headers["client"]).to be_present
        expect(headers["expiry"]).to be_present
        expect(headers["uid"]).to be_present
        expect(headers["token-type"]).to be_present

        expect(response).to have_http_status(:ok)
      end
    end

    context "nameが存在しないとき" do
      let(:params) { FactoryBot.attributes_for(:user, name: nil) }

      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["errors"]["name"]).to include "can't be blank"
      end
    end

    context "emailが存在しないとき" do
      let(:params) { FactoryBot.attributes_for(:user, email: nil) }

      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["errors"]["email"]).to include "can't be blank"
      end
    end

    context "passwordが存在しないとき" do
      let(:params) { FactoryBot.attributes_for(:user, password: nil) }

      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["errors"]["password"]).to include "can't be blank"
      end
    end
  end
end
