class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favourites
  # validates_presence_of :name, :ingredients, :preparation_description
  validates :name, presence: true, uniqueness: true
  validates :ingredients, presence: true
  validates :preparation_description, presence: true
  validates :image, presence: true
  validates :user, presence: true
end
