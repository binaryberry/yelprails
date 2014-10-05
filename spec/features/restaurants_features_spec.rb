require 'rails_helper'

def create_user
click_link "Sign_up"
expect(current_path).to eq "/users/sign_up"
fill_in 'Email', with: "robert@gmail.com"
fill_in 'Password', with: "RobotsRule"
fill_in 'Password confirmation', with: "RobotsRule"
click_button 'Sign up'
end

	describe 'displaying restaurants' do
		context'no restaurants were added' do
			it 'should display a prompt to add a restaurant'do
			visit'/restaurants'
			expect(page).to have_content("No restaurants were added")
			expect(page).to have_link("Add a restaurant")

			end
		end

		context"restaurants have been added" do
			before do
				Restaurant.create(name:'KFC')
			end

			it "should display them" do
				visit "/restaurants"
				expect(page).to have_content('KFC')
				expect(page).not_to have_content("No restaurants were added")
			end

		end
	end

	describe 'creating restaurants' do
		context 'a valid restaurant' do
		
			it "prompts user to fill a form" do
				visit '/restaurants'
				click_link 'Add a restaurant'
				fill_in 'Name', with: 'KFC'
				click_button 'Create Restaurant'
				expect(page).to have_content 'KFC'
				expect(current_path).to eq "/restaurants"
			end
		end	

		context 'an invalid restaurant' do
			it "does not let you submit a name that is too short" do
					visit '/restaurants'
					click_link 'Add a restaurant'
					fill_in 'Name', with: 'kf'
					click_button 'Create Restaurant'
					expect(page).not_to have_css 'h2', text: 'kf'
					expect(page).to have_content 'error'
				
			end	
		end
	end

	describe 'editing restaurants' do
		
		before do
				Restaurant.create(name:'KFC')
		end
		
		it "allows to edit a restaurant" do
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq "/restaurants"
		end

	end

	describe 'deleting restaurants' do
		before do
			@user = User.create(email: "andy@gmail.com", password: "huhuhuhu", password_confirmation: "huhuhuhu")
			@restaurant = @user.restaurants.create(name: "The Ivy")
		end

		context "when the user has created the restaurant" do

			it "removes a restaurant when a user clicks a delete link" do
				visit '/restaurants'
				click_link 'Sign_in'
				fill_in 'Email', with: "andy@gmail.com"
				fill_in 'Password', with: "huhuhuhu"
				click_button "Log in"
				click_link 'Delete The Ivy'
				expect(page).not_to have_content 'The Ivy'
				expect(page).to have_content "Restaurant deleted successfully" 
			end


		end

		context "when the user did not create the restaurant" do

			it "does not remove the restaurant" do
				visit "/"
				create_user
				click_link 'Delete The Ivy'
				expect(page).to have_content "Only the owner can delete this restaurant" 
				expect(page).to have_content "The Ivy" 
			end
		end
	end

	




