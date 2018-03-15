class Review < ApplicationRecord
  validates :review, presence: true
  validates :recipe, uniqueness: { scope: :user, message: "Already reviewed this recipe" }
  belongs_to :user
  belongs_to :recipe
end
