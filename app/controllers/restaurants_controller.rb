class RestaurantsController < ApplicationController

	def index
		@restaurants=Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(params[:restaurant].permit(:name))
		if @restaurant.save #had to make restaurant global variable here but Stephen didn't
			redirect_to restaurants_path
		else
			render 'new' #using render instead of redirect allows to have the page pre-populated
		end

	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(params[:restaurant].permit(:name))
		redirect_to restaurants_path
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.was_created_by?(current_user)
			@restaurant.destroy
			flash[:notice] = "Restaurant deleted successfully"
		else
			flash[:notice] = "Only the owner can delete this restaurant"
		end
		redirect_to restaurants_path
	end

end
