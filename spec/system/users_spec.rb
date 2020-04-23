require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成ができる'
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する'
      end
      context '登録済メールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する'
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する'
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集ができる'
        end
      end
      context 'メールアドレスが未入力時に' do
        it 'ユーザーの編集が失敗する'
      end
      context '登録済メールアドレスを使用' do
        it 'ユーザーの編集が失敗'
      end
      context '他ユーザーの編集ページにアクセス' do
        it 'アクセスが失敗する'
      end
    end

    describe 'マイページ' do
      context 'タスクを作成' do
        it '新規作成したタスクが表示される'
      end
    end
  end
end
