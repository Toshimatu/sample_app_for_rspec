require 'rails_helper'

RSpec.describe "Users", type: :system do

  let(:user) { create(:user) }
  let(:another_user) { create(:user, email: 'another@example.com')}

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      before do
        visit sign_up_path
      end

      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成ができる' do
          fill_in 'Email', with: 'example@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content('User was successfully created.')
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content("can't be blank")
        end
      end
      context '登録済メールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          user
          fill_in 'Email', with: 'factory@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content("Email has already been taken")
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'タスクの新規作成ページへの遷移ができないこと' do
          visit new_task_path(user)
          expect(page).to have_content("Login required")
        end
        it 'タスクの編集ページへの遷移ができないこと' do
          visit edit_task_path(user)
          expect(page).to have_content("Login required")
        end
        it 'マイページへのアクセスが失敗する' do
          visit user_path(user)
          expect(page).to have_content("Login required")
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      log_in
    end

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集ができる' do
          visit edit_user_path(user)
          fill_in 'Email', with: 'factoryedit@example.com'
          fill_in 'Password', with: 'edit'
          fill_in 'Password confirmation', with: 'edit'
          click_button 'Update'
          expect(page).to have_content('User was successfully updated.')
        end
      end
      context 'メールアドレスが未入力時に' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'edit'
          fill_in 'Password confirmation', with: 'edit'
          click_button 'Update'
          expect(page).to have_content("Email can't be blank")
        end
      end
      context '登録済メールアドレスを使用' do
        it 'ユーザーの編集が失敗' do
          visit edit_user_path(user)
          fill_in 'Email', with: another_user.email
          fill_in 'Password', with: 'edit'
          fill_in 'Password confirmation', with: 'edit'
          click_button 'Update'
          expect(page).to have_content('Email has already been taken')
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it 'アクセスが失敗する' do
          visit edit_user_path(another_user)
          expect(page).to have_content('Forbidden access.')
        end
      end
      context '他ユーザーのタスク編集ページにアクセス' do
        it 'アクセスが失敗する' do
          visit edit_task_path(another_user)
          expect(page).to have_content('Forbidden access')
        end
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される' do
          visit new_task_path(user)
          fill_in 'Title', with: 'タイトル'
          fill_in 'Content', with: 'コンテント'
          fill_in 'Deadline', with: '2020-04-25 23:59'
          click_button 'Create Task'
          expect(page).to have_content('Task was successfully created.')
        end
      end
    end
  end
end
