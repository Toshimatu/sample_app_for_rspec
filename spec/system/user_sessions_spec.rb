require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  let(:user) { create(:user) }

  describe 'ログイン前' do
    before do
      visit login_path
    end
    context 'フォームの入力値が正常' do
      it 'ログインが成功する' do
        user
        fill_in 'Email', with: 'factory@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content('Login successful')
      end
    end
    context 'フォームが未入力' do
      it 'ログインが失敗する' do
        user
        click_button 'Login'
        expect(page).to have_content('Login failed')
      end
    end
  end
  describe 'ログイン後' do
    before do
      log_in
    end
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        visit root_path
        click_on 'Logout'
        expect(page).to have_content('Logged out')
      end
    end
  end
end
