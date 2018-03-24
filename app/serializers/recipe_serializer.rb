class RecipeSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :image, :ingredients, :preparation_description, :created_at, :votes
  # model association
  belongs_to :user, key: :owner

  def votes
    object.get_votes
  end
end
