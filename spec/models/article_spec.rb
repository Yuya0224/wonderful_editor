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

      expect(article.status).to eq "draft"
      # binding.pry
    end
  end

  context "statusが下書きのとき" do
    let(:article) { build(:article, :draft) }
    it "下書きの状態である" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
      # binding.pry
    end
  end

  context "statusが公開のとき" do
    let(:article) { build(:article, :published) }

    it "公開の状態である" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
      # binding.pry
    end
  end
end
