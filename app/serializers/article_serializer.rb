# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
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
# class Api::V1::ArticleSerializer < ActiveModel::Serializer
#   attributes :id, :title, :body

#   has_many :comments
#   has_many :article_likes
#   belongs_to :user
# end
