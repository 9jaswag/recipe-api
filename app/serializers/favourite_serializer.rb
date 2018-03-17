class FavouriteSerializer < ActiveModel::Serializer
  belongs_to :recipe
end
