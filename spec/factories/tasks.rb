FactoryBot.define do
  factory :task do
    title { 'ファクトリタイトル' }
    status { :doing }
    user
  end
end
