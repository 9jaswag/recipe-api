class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favourites
  has_many :reviews
  # validates_presence_of :name, :ingredients, :preparation_description
  validates :name, presence: true
  validates :ingredients, presence: true
  validates :preparation_description, presence: true
  validates :image, presence: true
  validates :user, presence: true

  class << self
    def search(search_term)
      if search_term.blank?
        all
      else
        where('name LIKE ?', "%#{search_term}%")
      end
    end
  end

  def update_recipe_vote_count(recipe, type)
    if type == 'upvote'
      update_columns(upvotes: recipe.upvotes + 1)
    else
      update_columns(downvotes: recipe.downvotes + 1)
    end
  end
end
