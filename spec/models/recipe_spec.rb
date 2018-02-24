require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:all) do
    @user = build(:user)
    @recipe = create(:recipe, user: @user)
  end

  after(:all) do
    Recipe.delete_all
    User.delete_all
  end

  it "belongs to a user" do
    association = Recipe.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it "is valid" do
    expect(@recipe).to be_valid
  end

  it "validates recipe name" do
    @recipe.name = ""
    expect(@recipe).to_not be_valid
  end

  it "validates recipe ingredient" do
    @recipe.name = "Pasta Carbonara"
    @recipe.ingredients = ""
    expect(@recipe).to_not be_valid
  end

  it "validates recipe preparation description" do
    @recipe.ingredients = "salt, meat, vegetables"
    @recipe.preparation_description = ""
    expect(@recipe).to_not be_valid
  end

  it "saves a recipe" do
    @recipe.preparation_description = "lorem ipsum food is ready"
    @recipe.save!
    expect(Recipe.first.name).to eq 'Pasta Carbonara'
  end

  it "ensures recipe name is unique" do
    @recipe = build(:recipe, user: @user)
    expect(@recipe.save).to eq false
  end
end
