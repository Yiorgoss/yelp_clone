require 'rails_helper'

feature 'restaurants' do

  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'user_email', with: 'aaa@aaa.com'
    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: '12345678'
    click_button 'Sign up'
  end

  context 'no restaurants add yet' do
    scenario 'should display a prompt to add restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add Restaurant'
    end
  end

  context 'adding restaurants' do
    scenario 'should prompt user to create restaurant' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end
  end
  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'restaurants have been added' do

    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a new user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC' }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before {Restaurant.create name: 'KFC'}

    scenario 'removes restaurant when user clicks delete link' do

      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content "KFC"
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'limitation on users' do
    it 'must be logged in to create restaurants' do
      visit '/'
      click_link 'Sign out'
      click_link 'Add Restaurant'
      expect(page).not_to have_content 'Add Restaurant'
      expect(page).to have_content 'Log in'
    end

    # it 'can only edit restaurants which they have created' do

    # end

    # it 'users can only leave 1 review per restaurant' do

    # end

    # it 'can only delete their own reviews' do

    # end
  end

end
