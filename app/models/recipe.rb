class Recipe < ApplicationRecord
  # alias :read_attribute_for_serialization :send
  has_attached_file :image, default_url: "/system/recipes/images/placeholder.jpg"
  belongs_to :user
  has_many :favourites
  has_many :reviews
  has_many :votes
  # validates_presence_of :name, :ingredients, :preparation_description
  validates :name, presence: true
  validates :ingredients, presence: true
  validates :preparation_description, presence: true
  # validates :image, presence: true
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }, size: { in: 0..500.kilobytes }
  # do_not_validate_attachment_file_type :image
  validates :user, presence: true

  class << self
    def search(search_term)
      if search_term.blank?
        all
      else
        where('name LIKE ?', "%#{search_term}%")
      end
    end

    def most_voted
      all.map do |recipe|
        {
          recipe: recipe,
          votes: recipe.get_votes
        }
      end
    end
  end

  def update_recipe_vote_count(recipe, type, user_id)
    if type == 'upvote'
      current_value = votes.exists? ? votes[0].upvotes : 0
      votes.build(upvotes: current_value + 1, user_id: user_id)
    else
      current_value = votes.exists? ? votes[0].downvotes : 0
      votes.build(downvotes: current_value + 1, user_id: user_id)
    end
    save!
  end

  # get upvote and dowwnvotes for a recipe
  def get_votes
    puts '-------------------- 3'
    puts self.to_json
    puts '-------------------- 3'
    {
      upvotes: Vote.get_recipe_upvotes(self.id),
      downvotes: Vote.get_recipe_downvotes(self.id)
    }
  end
end
