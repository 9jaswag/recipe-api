class RecipesController < ApplicationController
  before_action :set_image_path, only: :create
  before_action :is_recipe_owner, only: %i[update destroy]
  before_action :paginate_per_page, only: %i[index user_favourites search]
  before_action :action_type, only: :upvote_or_downvote

  def index
    recipe = Recipe.all.paginate(page: params[:page], per_page: @per_page)
    json_response(recipe) if recipe
    render json: recipe.errors, status: :bad unless recipe
  end

  def create
    recipe = Recipe.create!(recipe_params)
    if recipe
      json_response(recipe, :created)
    else
      render json: recipe.errors, status: :bad
    end
  end

  def show
    recipe = Recipe.find(params[:id])
    if recipe
      render json: recipe, serializer: ShowRecipeSerializer
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
    json_response(recipe, :created)
  end

  def add_favourite
    recipe = Recipe.find(params[:recipe_id])
    recipe.favourites.build(user_id: params[:id])
    recipe.save!
  end

  def user_favourites
    favourites = Favourite.where(user_id: params[:id]).paginate(page: params[:page], per_page: @per_page)
    render json: favourites
  end

  def upvote_or_downvote
    recipe = Recipe.find(params[:recipe_id])
    recipe.update_recipe_vote_count(recipe, params[:type], params[:id])
    json_response(recipe)
  end

  def search
    recipe = Recipe.search(params[:term]).paginate(page: params[:page], per_page: @per_page)
    json_response(recipe)
  end

  def most_votes
    recipe = Recipe.most_voted
    render json: recipe, serializer: MostVotesSerializer
  end

  private

  def recipe_params
    params.permit(:name, :image, :ingredients, :preparation_description, :user_id)
  end

  def set_image_path
    params.delete('image') if params[:image] == "undefined"
  end

  def is_recipe_owner
    recipe = Recipe.find(params[:recipe_id])
    if recipe.user.id != params[:id].to_i
      raise(
        ExceptionHandler::AuthenticationError, "You don't have permission for that action"
      )
    end
  rescue ActiveRecord::RecordNotFound
  end

  def paginate_per_page
    # set pagination per_page
    @per_page = params.key?(:per_page) ? params[:per_page] : 10
  end

  def action_type
    raise(ExceptionHandler::BadRequest, 'Wrong action type provided') unless params[:type] == 'upvote' || params[:type] == 'downvote'
  end
end
