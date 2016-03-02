require 'rails_helper'

feature 'user deleting restaurant' do
  it 'can only be done by the creating user' do
    visit('/')
    sign_up
    create_restaurant
    click_link 'Sign out'
    sign_up_other
    click_link 'Delete KFC'
    expect(page).not_to have_content 'deleted successfully'
  end
end
