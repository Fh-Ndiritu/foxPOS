# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# if Rails.env.developmemt?
#   ActiveStorage::Current.url_options = { host: 'localhost:3000' }
#   10.times do
#     FactoryBot.create(:category) do |category|
#       2.times { FactoryBot.create(:product, category:) }
#     end
#   end
#  end


#  password = '12345678'
#  admin = User.create!(email: 'super_admin@foxpos.com', password:, role: 'super_admin')
#  Rails.logger.info "Admin user created with email: #{admin.email} and password: #{password}"

begin
  # Create admin user if it doesn't exist
  password = '12345678'
  admin = User.find_or_create_by!(email: 'super_admin@foxpos.com') do |user|
    user.password = password
    user.role = 'super_admin'
    user.full_name = 'Super Admin' # Adding required full_name field
  end
  
  Rails.logger.info "Admin user created/verified with email: #{admin.email}"

  # Only create sample data in development
  if Rails.env.development?
    Rails.logger.info "Creating sample data for development environment..."
    
    # Create categories and products if they don't exist
    10.times do |i|
      category = Category.find_or_create_by!(name: "Category #{i + 1}")
      
      2.times do |j|
        Product.find_or_create_by!(
          name: "Product #{j + 1}",
          category: category,
          price: rand(100..1000),
          description: "Description for product #{j + 1}"
        )
      end
    end
    
    Rails.logger.info "Sample data created successfully"
  end
rescue => e
  Rails.logger.error "Error in seeds.rb: #{e.message}"
  Rails.logger.error e.backtrace.join("\n")
end
