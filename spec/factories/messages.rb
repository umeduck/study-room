FactoryBot.define do
  factory :message do
    content {'HELLO'}
    
    association :room
    association :user
  end
end
