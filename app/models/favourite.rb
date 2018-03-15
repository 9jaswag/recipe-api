class Favourite < ApplicationRecord
  validates :recipe, uniqueness: { scope: :user, message: "Already a favourite recipe" }
  belongs_to :user
  belongs_to :recipe
end
