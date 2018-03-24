class Vote < ApplicationRecord
  validates :recipe, uniqueness: { scope: :user, message: 'Already upvoted recipe' }
  belongs_to :recipe
  belongs_to :user

  class << self
    def collate_upvotes
      {
        upvotes: self.upvotes,
        downvotes: self.downvotes,
      }
    end

    def upvotes
      all.group(:recipe_id).sum(:upvotes)
    end

    def downvotes
      all.group(:recipe_id).sum(:downvotes)
    end

    def get_recipe_upvotes(recipe_id)
      where(recipe_id: recipe_id).sum(:upvotes)
    end

    def get_recipe_downvotes(recipe_id)
      where(recipe_id: recipe_id).sum(:downvotes)
    end
  end
end
