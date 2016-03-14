require "rails_helper"

RSpec.feature "Searching for User" do
  before do
    @john_doe = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @jane_doe = User.create(first_name: "Jane", last_name: "Doe", email: "jane@example.com", password: "password")  
  end
  
  scenario do
    visit "/"
    
    fill_in "search_name", with: "Doe"
    click_button "Search"
     
    expect(page).to have_content(@john_doe.full_name)
    expect(page).to have_content(@jane_doe.full_name)
    expect(current_path).to eq("/dashboard/search")
    
  end
  
end