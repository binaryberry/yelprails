require 'rails_helper'

describe 'sessions' do
	def create_user
	click_link "Sign_up"
	expect(current_path).to eq "/users/sign_up"
	fill_in 'Email', with: "robert@gmail.com"
	fill_in 'Password', with: "RobotsRule"
	fill_in 'Password confirmation', with: "RobotsRule"
	click_button 'Sign up'
	end

	context "signing up" do


		it "allows users to sign up using a form on home page" do
			visit '/'
			create_user
			expect(current_path).to eq "/"
			expect(page).to have_content 'Welcome! You have signed up successfully.'
		end

		it 'does not allow a user to sign in twice' do
			visit '/'
			create_user
			click_link 'Sign_out'
			create_user
			expect(current_path).to eq "/users"
			expect(page).to have_content '1 error prohibited this user from being saved:'
			expect(page).to have_content 'Email has already been taken'
			expect(page).not_to have_content 'Welcome! You have signed up successfully.'

		end

		xit "allows a user to sign in through Facebook" do
			visit '/'
			click_link 'Sign_up'
			expect(current_path).to eq "/users/sign_up"
			click_link 'Sign in with Facebook'
			expect(page).to have_content 'Successfully authenticated from Facebook account.'
			expect(current_path).to eq "/"

		end

	end

	context "signing out" do

		it "allows users to sign out" do
			visit '/'
			create_user
			click_link('Sign_out')
			expect(current_path).to eq "/"
			expect(page).to have_content "Signed out successfully."
			expect(page).not_to have_content "Sign out"
		end

	end


end
