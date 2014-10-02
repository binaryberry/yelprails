# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Restaurant.destroy_all
Review.destroy_all


kfc = Restaurant.create(:name => "KFC")
kfc.reviews.create(rating: 1, thoughts: "bad")
kfc.reviews.create(rating: 2, thoughts: "ok")
kfc.reviews.create(rating: 3, thoughts: "so so")
kfc.reviews.create(rating: 4, thoughts: "good")
kfc.reviews.create(rating: 5, thoughts: "awesome")

jamies = Restaurant.create(:name => "Jamie's Italian")
jamies.reviews.create(rating: 1, thoughts: "I puked")
jamies.reviews.create(rating: 2, thoughts: "really ok")
jamies.reviews.create(rating: 3, thoughts: "really so so")
jamies.reviews.create(rating: 4, thoughts: "really good")
jamies.reviews.create(rating: 5, thoughts: "really awesome")