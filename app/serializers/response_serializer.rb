class ResponseSerializer < ActiveModel::Serializer
  attributes :recipe, :user
end


def recipe
  RecipeSerializer.new(object.recipe)
end

def user
  RecipeSerializer.new(object.recipe.user)
end

class RecipeSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :image, :ingredients, :preparation_description, :upvotes, :downvotes, :created_at
  # model association
  belongs_to :user
end
