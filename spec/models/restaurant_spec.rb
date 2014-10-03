require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
	it "is not valid with a name of less than 3 characters" do
		restaurant = Restaurant.new(name: "kf")
		expect(restaurant).to have(1).error_on(:name)
		expect(restaurant).not_to be_valid

	end

	it "is not valid unless it is a unique name" do
		Restaurant.create(name: "The Ivy")
		restaurant = Restaurant.new(name: "The Ivy")
		expect(restaurant).to have(1).error_on(:name)

	end

	describe '#average_rating' do
		context 'no reviews' do
			it "returns N/A" do
			restaurant = Restaurant.create(name: "The Ivy")
			expect(restaurant.average_rating).to eq "N/A"
			end
		end

		context 'one review' do
			it "returns that rating" do
			restaurant = Restaurant.create(name: "The Ivy")
			restaurant.reviews.create(rating: 4)
			expect(restaurant.average_rating).to eq 4
			end
		end

			context 'multiple reviews' do
			it "returns that rating" do
			restaurant = Restaurant.create(name: "The Ivy")
			restaurant.reviews.create(rating: 3)
			restaurant.reviews.create(rating: 5)
			expect(restaurant.average_rating).to eq 4
			end
		end

	end

	describe "belongs to a user" do
			context "when the user creates a restaurant" do
			
			before do
				@user = User.create(email: "robert@gmail.com", password: "huhuhuhu", password_confirmation: "huhuhuhu")
				@restaurant = @user.restaurants.create(name: "The Ivy")
			end

				it "knows the restaurant belongs to that user" do
				expect(@restaurant.was_created_by?(@user)).to eq true
				end

				it "knows when a restaurant doesn't belong to a user" do
				another_user = User.create(email: "nicola@gmail.com", password: "lalalala", password_confirmation: "lalalala")
				expect(@restaurant.was_created_by?(another_user)).to eq false
				end

			end



	end

end