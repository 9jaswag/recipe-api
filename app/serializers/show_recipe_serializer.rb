class ShowRecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :ingredients, :preparation_description, :created_at

  belongs_to :user
  has_many :votes
  has_many :reviews
end
