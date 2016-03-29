require "rails_helper"

RSpec.feature "Un-Following Friends" do
  before do
    @sarah = User.create(first_name: "Sarah", last_name: "Doe", email: "sarah@example.com", password: "password")
    @joe = User.create(first_name: "Joe", last_name: "Ed", email: "joe@example.com", password: "password")
    
    login_as(@joe)
    @following = Friendship.create(user: @joe, friend: @sarah)
  end
  
  scenario do

    visit "/"
    click_link "My Lounge"
    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click
    
    expect(page).to have_content(@sarah.full_name + " unfollowed")
  end  
  
end