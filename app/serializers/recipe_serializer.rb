class RecipeSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :name, :image, :ingredients, :preparation_description, :created_at
  # model association
  belongs_to :user, key: :owner
  has_many :votes

  def votes
    object.get_votes
  end
end
