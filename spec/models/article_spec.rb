# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  state      :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# RSpec.describe Article, type: :model do
#   # pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Article, type: :model do
  context "titleとbodyがあるとき" do
    let(:article) { build(:article) }

    it "下書きの記事が作成される" do
      expect(article).to be_valid

      expect(article.state).to eq "draft"
      # binding.pry
    end
  end

  context "stateが0のとき" do
    let(:article) { build(:article, state: 0) }
    it "下書きの状態である" do
      expect(article).to be_valid
      expect(article.state).to eq "draft"
      # binding.pry
    end
  end

  context "stateが1のとき" do
    let(:article) { build(:article, state: 1) }

    it "公開の状態である" do
      expect(article).to be_valid
      expect(article.state).to eq "release"
      # binding.pry
    end
  end
end
