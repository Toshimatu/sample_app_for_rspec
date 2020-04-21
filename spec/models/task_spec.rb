require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:task) { create(:task) }

  # titleが存在しなければ無効であること
  it "is invalid without a title" do
    task = Task.new(title: nil, status: 'doing')
    expect(task).to be_invalid
  end

  # titleの値が重複していれば無効であること
  it "is invalid with a duplicate task's title" do
    task
    duplicated_task = Task.create(title: 'テストタイトル', status: 'todo')
    duplicated_task.valid?
    expect(duplicated_task.errors[:title]).to include("has already been taken")
  end

  # statusが存在しなければ無効であること
  it "is invalid without a status" do
    task = Task.new(title: 'テストタイトル', status: nil)
    task.invalid?
    expect(task.errors[:status]).to include("can't be blank")
  end

  # 項目に過不足がないデータはバリデーションエラーとならずに正常に作成できること
  it "is valid when it has a sufficient value" do
    task
    task.invalid?
    expect(task.errors[:title]).to include()
    expect(task.errors[:status]).to include()
  end
end
