class Review < ApplicationRecord
  validates :review, presence: true
  validates :recipe, uniqueness: { scope: :user, message: 'already reviewed by user' }
  belongs_to :user
  belongs_to :recipe
end
