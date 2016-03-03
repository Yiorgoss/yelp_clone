class RestaurantsController < ApplicationController
  include WithUserAssociationExtension
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
    @reviews = Review.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    p current_user.id
    p @restaurant.user_id
    if @restaurant.user_id == current_user.id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'Can\'t delete Restaurant, you didn\'t add'
      redirect_to '/restaurants'
    end
  end
end
