require 'rails_helper'

RSpec.describe Review, :type => :model do
	it "does not allow a review to be lower than 1" do
		review = Review.new(rating: -1)
		expect(review).to have(1).error_on(:rating)
		expect(review).not_to be_valid

	end

	it "does not allow a review to be higher than 5" do
		review = Review.new(rating: 6)
		expect(review).to have(1).error_on(:rating)
		expect(review).not_to be_valid

	end
	
	it "is a valid rating between 1 and 5" do
		review = Review.new(rating: 4)
		expect(review).to be_valid
	end
end