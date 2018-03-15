class RecipesController < ApplicationController
  before_action :set_image_path, only: :create
  before_action :is_recipe_owner, only: [:update, :destroy]
  before_action :paginate_per_page, only: :index

  def index
    recipe = Recipe.all.paginate(:page => params[:page], :per_page => @per_page)
    json_response(recipe) if recipe
    render json: recipe.errors, status: :bad unless recipe
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
    recipe.destroy if recipe
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

  def add_favourite
    recipe = Recipe.find(params[:recipe_id])
    recipe.favourites.build(user_id: params[:id])
    recipe.save!
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

    def paginate_per_page
      # set pagination per_page
      @per_page = params.has_key?(:per_page) ? params[:per_page] : 10
    end
end

# /recipes/:recipe_id/user/:id(.:format) recipes#user_favourites
