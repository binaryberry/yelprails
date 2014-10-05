require 'rails_helper'

describe 'reviewing' do
	def create_user
	click_link "Sign_up"
	expect(current_path).to eq "/users/sign_up"
	fill_in 'Email', with: "robert@gmail.com"
	fill_in 'Password', with: "RobotsRule"
	fill_in 'Password confirmation', with: "RobotsRule"
	click_button 'Sign up'
	end

	before do
		
		Restaurant.create(name: 'KFC')
	end

	def leave_review(thoughts, rating)
		visit '/restaurants'
		click_link 'Review KFC'
		fill_in 'Thoughts', with: thoughts
		select rating, from: 'Rating'
		click_button 'Leave review'

	end

		it "allows users to leave reviews using the form which appears alongside restaurants" do
			leave_review("so so","3")
			expect(current_path).to eq "/restaurants"
			expect(page).to have_content 'so so'
		end

		it "displays an average rating for all reviews" do
			leave_review("So so","3")
			leave_review("Great","5")
			expect(page).to have_content 'Average rating: ★★★★☆'
		end

		# it "does not allow him to leave a review of his own restaurant" do
		# 	visit "/"
		# 	click_link 'Sign_in'
		# 	fill_in 'Email', with: "andy@gmail.com"
		# 	fill_in 'Password', with: "huhuhuhu"
		# 	click_button "Log in"
		# 	click_link "Add a restaurant"
		# 	fill_in "The Ivy"
		# 	click_button "Create restaurant"
		# 	click_link 'Review The Ivy'
		# 	expect(page).to have_content "You cannot review your own restaurant" 
		# 	expect(page).not_to have_content 'The Ivy'
		# end
end