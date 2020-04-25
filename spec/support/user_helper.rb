module UserHelpers
  def log_in
    user
    visit login_path
    fill_in 'Email', with: 'factory@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end
end