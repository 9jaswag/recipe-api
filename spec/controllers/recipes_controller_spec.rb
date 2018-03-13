require 'rails_helper'

RSpec.describe 'Recipes API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }
  before do
    @valid_header = {
      "Authorization" => JsonWebToken.encode(user_id: user.id),
      "Content-Type" => "application/json"
    }
  end

  # GET /recipes/:id
  describe 'GET /recipes/:id' do
    context 'when request is valid' do
      # make HTTP post request before each example
      before { get "/recipes/#{recipe.id}", headers: @valid_header }

      it 'returns a recipe with that matches the provided recipe id' do
        expect(response.body.include?(recipe.name)).to eq true
      end
    end
  end

  #POST /recipes
  # describe 'POST /recipes' do
  #   before do
  #     post "/recipes", headers: @valid_header, params: {
  #                                                 # name: 'Pasta Carbonara',
  #                                                 # image: 'image_path',
  #                                                 # ingredients: 'salt, pepper, maggi',
  #                                                 # preparation_description: 'this is how to prepare this food.',
  #                                                 # user_id: user.id
  #                                               }
  #   end
    
  #   it "creates a new recipe" do
  #     puts response.body
  #     expect(response.body.include?('Pasta Carbonara')).to eq true
  #   end
  # end
  # /recipes/:recipe_id/user/:id
end
