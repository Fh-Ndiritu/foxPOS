FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price(range: 10..100.0) }
    active { [ true, false ].sample }
    category
    size { %w[Medium Large Small].sample }
    stock { rand(1..99) }
    availability { [ 0, 1 ].sample }
    after(:build) do |product|
        # Try to fetch an existing image blob
        existing_image = ActiveStorage::Blob.where(content_type: "image/png").sample

        if existing_image
          product.image.attach(existing_image)
        else
          # Fallback to a fixture image
          product.image.attach(
            io: File.open(Rails.root.join('spec',  'files', 'test.jpg')),
            filename: 'test.jpg',
            content_type: 'image/jpg'
          )
        end
      end
    end
end
