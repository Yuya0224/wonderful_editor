# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  password               :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context "name,email,passwordを指定しているとき" do
    it "ユーザーが作られる" do
      # binding.pry
      user = FactoryBot.build(:user)
      # binding.pry
      expect(user).to be_valid
    end
  end

  context "nameを指定していないとき" do
    it "ユーザーが作られない" do
      user = FactoryBot.build(:user, name: nil)
      # binding.pry
      # user = User.new(name: "fo",email: "fo@example.com", password: "focccccccc")
      # binding.pry
      expect(user).to be_invalid
    end
  end

  context "emailを指定していないとき" do
    it "ユーザーが作られない" do
      user = FactoryBot.build(:user, email: nil)
      # binding.pry
      # user = User.new(name: "fo",email: "fo@example.com", password: "focccccccc")
      # binding.pry
      expect(user).to be_invalid
    end
  end

  context "passwordを指定していないとき" do
    it "ユーザーが作られない" do
      user = FactoryBot.build(:user, password: nil)
      # binding.pry
      # user = User.new(name: "fo",email: "fo@example.com", password: "focccccccc")
      # binding.pry
      expect(user).to be_invalid
    end
  end
end
