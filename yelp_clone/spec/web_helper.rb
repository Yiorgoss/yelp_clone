def sign_up
  click_link 'Sign up'
  fill_in 'Email', with: 'yo@random.com'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
  click_button 'Sign up'
end

def create_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end

def sign_up_other
  click_link 'Sign up'
  fill_in 'Email', with: 'hello@random.com'
  fill_in 'Password', with: 'password123'
  fill_in 'Password confirmation', with: 'password123'
  click_button 'Sign up'
end
