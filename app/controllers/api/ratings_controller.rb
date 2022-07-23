# frozen_string_literal: true
class Api::RatingsController < Api::BaseController
  before_action :doorkeeper_authorize!, only: %w[index create show update destroy]
  before_action :current_user_authenticate, only: %w[index create show update destroy]

  before_action :set_recipe
  before_action :set_rating, only: %i[show update destroy]

  def show
    render json: @rating
  end

  def create
    @rating = Rating.new(rating_params.merge(user_id: 1, recipe_id: @recipe.id))

    if @rating.save
      render json: @rating
    else
      render json: { detail: @rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @rating

    @rating.destroy!
  end

  def update
    authorize @rating

    if @rating.update!(rating_params)
      render json: @rating
    else
      render json: { detail: @rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @ratings = @recipe.ratings.includes(:user)

    render json: @ratings
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:ratings).permit(:score)
  end
end
