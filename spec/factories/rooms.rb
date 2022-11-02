FactoryBot.define do
  factory :room do
    title {'room1'}

    association :user
  end
end
