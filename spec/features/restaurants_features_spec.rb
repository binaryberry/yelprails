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
		it "prompts user to fill a form" do
			visit '/restaurants'
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants"
		end

	end