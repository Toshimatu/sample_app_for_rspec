require 'rails_helper'

RSpec.describe "Tasks", type: :system do

  let(:user) { create(:user) }
  let(:another_user) { create(:user, email: 'another@example.com')}

  describe 'ログイン後' do
    before do
      log_in
      create(:task, user_id: user.id)
    end

    context 'タスクの新規作成' do
      it 'タスクの新規作成ができること' do
        visit new_task_path
        fill_in 'Title', with: '作成したタスク'
        select 'todo', from: 'Status'
        click_button 'Create Task'
        expect(page).to have_content('Task was successfully created.')
      end
    end
    context 'タスクの編集' do
      it 'タスクの編集ができること' do
        visit edit_task_path(user)
        fill_in 'Title', with: 'タスク編集'
        select 'doing', from: 'Status'
        click_button 'Update Task'
        expect(page).to have_content('Task was successfully updated.')
      end
    end
    context 'タスクの削除' do
      it 'タスクの削除ができること' do
        visit tasks_path(user)
        click_on 'Destroy'
        page.accept_confirm "Are you sure?"
        expect(page).to have_content('Task was successfully destroyed.')
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
