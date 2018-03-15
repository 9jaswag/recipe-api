class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :review, :created_at
  belongs_to :user
end
