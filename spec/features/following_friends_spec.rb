require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @cathy = User.create(first_name: "Cathy", last_name: "Doe", email: "cathy@example.com", password: "password")
    @pierre = User.create(first_name: "Pierre", last_name: "Ed", email: "pierre@example.com", password: "password")
    
    login_as(@cathy)
  end
  
  scenario "if signed in succeeds" do
    visit "/"
    
    expect(page).to have_content(@cathy.full_name)
    expect(page).to have_content(@pierre.full_name)
    expect(page).not_to have_link("Follow", :href => "/friendships?friend_id=#{@cathy.id}")
    
    link = "a[href='/friendships?friend_id=#{@pierre.id}']"
    find(link).click
    
    expect(page).not_to have_link("Follow", :href => "/friendships?friend_id=#{@pierre.id}")
  end  
  
end