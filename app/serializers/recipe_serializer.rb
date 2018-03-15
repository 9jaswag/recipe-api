class RecipeSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :image, :ingredients, :preparation_description, :upvotes, :downvotes, :created_at
  # model association
  belongs_to :user
end
