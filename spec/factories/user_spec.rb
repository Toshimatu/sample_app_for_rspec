FactoryBot.define do
  factory :user do
    email { 'factory@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end