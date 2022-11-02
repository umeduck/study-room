FactoryBot.define do
  factory :user do
    name {'太郎'}
    school_year_id {2}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 8)}
    password_confirmation {password}
  end
end
