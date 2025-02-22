FactoryBot.define do
  factory :category do
    name  { Faker::Commerce.department }
    active { true }
    description { Faker::Lorem.paragraph }
    after(:build) do |category|
      category.image.attach(
        io: File.open(Rails.root.join('spec',  'files', 'test.jpg')),
        filename: 'test.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
