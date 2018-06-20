class ReviewsController < ApplicationController
  include WithUserAssociationExtension

  def new
    if current_user.has_reviewed? @restaurant
      flash[:notice] = 'You have already reviewed this restaurant'
    end

    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        flash[:notice] = 'You have already reviewed this restaurant'
        redirect_to '/restaurants'
      else
        render :new
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    p @review.user_id
    p current_user.id
    if @review.user_id == current_user.id
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'Can\'t delete Review, you didn\'t add'
      redirect_to '/restaurants'
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
