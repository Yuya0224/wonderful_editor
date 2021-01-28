class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email


  # has_many :comments
  # has_many :article_likes
  # belongs_to :user
end
