require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:task_a) { FactoryBot.create(:task) }

  # titleが存在しなければ無効であること
  it "is invalid without a title" do
    task = Task.new(title: nil, status: 1)
    task.valid?
    expect(task.errors[:title]).to include("can't be blank")
  end

  # titleの値が重複していれば無効であること
  it "is invalid with a duplicate task's title" do
    task_a
    task = Task.create(title: 'テストタイトル', status: 1)
    task.valid?
    expect(task.errors[:title]).to include("has already been taken")
  end

  # statusが存在しなければ無効であること
  it "is invalid without a status" do
    task = Task.new(title: 'テストタイトル', status: nil)
    task.invalid?
    expect(task.errors[:status]).to include("can't be blank")
  end
end
