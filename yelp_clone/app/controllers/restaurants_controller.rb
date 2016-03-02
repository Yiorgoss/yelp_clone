class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @reviews = Review.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
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
   @restaurant.destroy
   flash[:notice] = 'Restaurant deleted successfully'
   redirect_to '/restaurants'
 end
end