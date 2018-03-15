class RecipesController < ApplicationController
  before_action :set_image_path, only: :create
  before_action :is_recipe_owner, only: [:update, :destroy]

  def index
    recipe = Recipe.all
  end

  def create
    recipe = Recipe.create!(recipe_params)
    if recipe
      response = {
        message: 'Recipe created',
        recipe: recipe
      }
      json_response(response, :created)
    else
      render json: recipe.errors,status: :bad
    end
  end

  def show
    recipe = Recipe.find(params[:id])
    if recipe
      response = {
        message: "Recipe found",
        recipe: recipe
      }
      json_response(response)
    else
      render json: recipe.errors, status: :bad
    end
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
  end

  def update
    recipe = Recipe.find(params[:recipe_id])
    recipe.update!(recipe_params)
    # render json: [recipe]
    # response = {
    #   message: 'Recipe updated!',
    #   recipe: recipe
    # }
    json_response(recipe, :created)
  end

  private
    def recipe_params
      params.permit(:name, :image, :ingredients, :preparation_description, :user_id)
    end

    def set_image_path
      params[:image] = 'default image path' unless params[:image]
    end

    def is_recipe_owner
      recipe = Recipe.find(params[:recipe_id])
      raise(
        ExceptionHandler::AuthenticationError, "You don't have permission for that action"
      ) if recipe.user.id != params[:id].to_i
    rescue ActiveRecord::RecordNotFound
    end
end
