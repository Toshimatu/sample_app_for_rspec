FactoryBot.define do
  factory :task do
    title { 'テストタイトル' }
    status { :doing }
    user
  end
end
