require 'rails_helper'


	describe 'restaurants' do
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