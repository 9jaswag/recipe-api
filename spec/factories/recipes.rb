FactoryBot.define do
  factory :recipe do
    name "My Recipe"
    image "Image Path"
    ingredients "Recipe Ingredient"
    preparation_description "Recipe Preparation Description"
    upvotes 1
    downvotes 1
    user nil
  end
end
