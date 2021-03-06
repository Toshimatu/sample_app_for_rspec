require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  let(:user) { create(:user) }
  let(:another_user) { create(:user, email: 'another@example.com')}

  describe 'ログイン後' do
    before do
      log_in
      create(:task, user_id: user.id)
    end
    describe 'タスクの新規作成'
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成ができること' do
          visit new_task_path(user)
          fill_in 'Title', with: '作成したタスク'
          select 'todo', from: 'Status'
          click_button 'Create Task'
          expect(page).to have_content('Task was successfully created.')
          expect(page).to have_content('作成したタスク')
        end
      context 'タイトルが未入力時に' do
        it 'タスクの作成が失敗すること' do
          visit new_task_path(user)
          select :todo, from: 'Status'
          click_button 'Create Task'
          expect(page).to have_content("Title can't be blank")
          expect(current_path).to eq tasks_path
        end
      end
      context '作成済みのタイトルを使用' do
        it 'タスクの作成が失敗' do
          visit new_task_path(user)
          fill_in 'Title', with: 'テストタイトル'
          select :todo, from: 'Status'
          click_button 'Create Task'
          expect(page).to have_content('Title has already been taken')
          expect(page).to_not have_content('テストタイトル')
          expect(current_path).to eq tasks_path
        end
      end
    end
    describe 'タスクの編集' do
      context 'フォームの入力値が正常' do
        it 'タスクの編集ができること' do
          visit edit_task_path(user)
          fill_in 'Title', with: 'タスク編集'
          select :doing, from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content('Task was successfully updated.')
          expect(page).to have_content('タスク編集')
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの編集ができないこと' do
          visit edit_task_path(user)
          fill_in 'Title', with: ''
          select :todo, from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content("Title can't be blank")
        end
      end
      context '作成済みのタイトルを使用' do
        it 'タスクの編集ができないこと' do
          task = Task.create(title: '作成済みタイトル', status: :todo)
          visit edit_task_path(user)
          fill_in 'Title', with: '作成済みタイトル'
          select :todo, from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content("Title has already been taken")
        end
      end
    end
    context 'タスクの削除' do
      it 'タスクの削除ができること' do
        visit tasks_path(user)
        click_on 'Destroy'
        page.accept_confirm "Are you sure?"
        expect(page).to have_content("Task was successfully destroyed.")
        expect(current_path).to eq tasks_path
      end
    end
    context '他ユーザーのタスク編集ページにアクセス' do
      it 'アクセスが失敗する' do
        another_task = Task.create(title: '他ユーザーのタスク', status: :todo)
        visit edit_task_path(another_user)
        expect(page).to have_content('Forbidden access.')
      end
    end
  end
end
