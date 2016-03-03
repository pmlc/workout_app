require "rails_helper"

RSpec.feature "Editing Exercises" do
  
  before do
    @owner = User.create(first_name: "John",
                        last_name: "Doe",
                        email: "john@example.com", 
                        password: "password")
    @owner_exercise = @owner.exercises.create!(duration_in_min: 10, workout: "Body building routine", workout_date: Date.today)
    
    login_as(@owner)
  end

  scenario "with valid modifications" do
    visit "/"
    
    click_link "My Lounge"
    link = "a[href='/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit']"
    find(link).click

    fill_in "Duration", with: 20
    
     click_button "Update Exercise"
    
    expect(page).to have_content("Exercise has been updated")
    expect(page).to have_content(20)
    expect(page).not_to have_content(10)

  end
end