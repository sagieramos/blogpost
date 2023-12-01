FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { 'Sample Post' }
  end
end
