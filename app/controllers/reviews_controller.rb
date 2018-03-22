class ReviewsController < ApplicationController
  def add_review
    review = Review.create(review_params)
    review.save!
    json_response(review, :created)
  end

  private

  def review_params
    params.permit(:review, :user_id, :recipe_id)
  end
end
