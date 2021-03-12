FactoryBot.define do
  factory :message do
   text { "test message" }
  end

  factory :user do
    username { "Tony Stark" }
  end
end
