 # This file should ensure the existence of records required to run the application in every environment (production,
 # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
 # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
 #
 # Example:
 #
 #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
 #     MovieGenre.find_or_create_by!(name: genre_name)
 #   end

 if Rails.env.developmemt?
  ActiveStorage::Current.url_options = { host: 'localhost:3000' }
  10.times do
    FactoryBot.create(:category) do |category|
      2.times { FactoryBot.create(:product, category:) }
    end
  end
 end


 password = '12345678'
 admin = User.create!(email: 'admin@foxpos.com', password: , role: 'admin')
 Rails.logger.info "Admin user created with email: #{admin.email} and password: #{password}"

