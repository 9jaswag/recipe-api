FactoryBot.define do
  factory :user do
    username "chuks"
    email "chuks@email.com"
    password "secret_password"
    is_admin true
  end
end
