class ShowRecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :ingredients, :preparation_description, :created_at, :votes

  belongs_to :user, key: :owner
  has_many :votes
  has_many :reviews

  def votes
    object.get_votes
  end
end
