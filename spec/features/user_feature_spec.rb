require 'rails_helper'

describe 'sessions' do
	# before do
	# 	Restaurant.create(name: 'KFC')
	# end
	context "signing up" do

		it "allows users to sign up using a form on home page" do
			visit '/'
			click_link "Sign_up"
			expect(current_path).to eq "/users/sign_up"
			fill_in 'Email', with: "robert@gmail.com"
			fill_in 'Password', with: "RobotsRule"
			fill_in 'Password confirmation', with: "RobotsRule"
			click_button 'Sign up'
			expect(current_path).to eq "/"
			expect(page).to have_content 'Welcome! You have signed up successfully.'
		end

	end
end
