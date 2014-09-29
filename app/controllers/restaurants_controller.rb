class RestaurantsController < ApplicationController

	def index
		@restaurants=Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		restaurant = Restaurant.create(params[:restaurant])
		redirect restaurants_path
	end

end
