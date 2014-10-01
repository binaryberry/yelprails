require 'rails_helper'


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
			Restaurant.create(name: 'KFC')
		end

		it "removes a restaurant when a user clicks a delete link" do
			visit '/restaurants'
			click_link 'Delete KFC'
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content "Restaurant deleted successfully" 

		end
	end

	describe 'dedicated restaurant page' do
		before do
			@restaurant = Restaurant.create(name: 'Nandos', description: "This Nandos doesn't do naan bread")
		end

		it "displays the restaurant page" do
			visit '/restaurants'
			click_link 'Show Nandos'
			expect(page).to have_content 'This Nandos doesn\'t do naan bread'
			expect(current_path).to match(/restaurants\/\d/)
		end
	end

	




