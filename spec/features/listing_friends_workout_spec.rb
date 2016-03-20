require "rails_helper"

RSpec.feature "Listing Friends workout details" do
  before do
    @cathy = User.create(first_name: "Cathy", last_name: "Doe", email: "cathy@example.com", password: "password")
    @pierre = User.create(first_name: "Pierre", last_name: "Le-Count", email: "pierre@example.com", password: "password")
    @e1 = @pierre.exercises.create(duration_in_min: 40, workout: "Gymnastics - handstand and iron cross", workout_date: Date.today)
    
    login_as(@cathy)
    @following = Friendship.create(user: @cathy, friend: @pierre)
  end
  
  scenario "showing friends latest workouts" do
    visit "/"
    click_link "My Lounge"
    click_link @pierre.full_name
    expect(page).to have_content(@pierre.full_name + "'s Exercises")
    expect(page).to have_content(@e1.workout)
    
  end  
  
end