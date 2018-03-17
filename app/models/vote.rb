class Vote < ApplicationRecord
  validates :recipe, uniqueness: { scope: :user, message: 'Already upvoted recipe' }
  belongs_to :recipe
  belongs_to :user
end
