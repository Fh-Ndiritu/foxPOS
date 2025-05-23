# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# this ensures logs are seen in terminal even for docker
Rails.logger = Logger.new(STDOUT)

def create_categories_and_products
  return if Category.any? || Product.any?

  Rails.logger.info "Seeding Categories and Products ######"

  10.times do |i|
    category = Category.new(name: "Category #{i + 1}").tap do |imageable|
      imageable.image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar.png')),
        filename: 'avatar.png',
        content_type: 'image/png'
      )
      imageable.save!
    end

    2.times do |j|
      Product.new(
        name: "Product #{j + 1}",
        category: category,
        price: rand(100..1000),
        description: "Description for product #{j + 1}"
      ).tap do |imageable|
          imageable.image.attach(
            io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar.png')),
            filename: 'avatar.png',
            content_type: 'image/png'
          )
          imageable.save!
      end
    end
  end
end

def create_or_verify_super_admin
  Rails.logger.info "\nVerifying Super Admin account"
  admin = User.find_by(email: 'super_admin@foxpos.com')

  unless admin.present?
    password = '12345678'
    admin = User.create!(
      email: 'super_admin@foxpos.com',
      password: password,
      role: :super_admin,
      full_name: 'Super Admin'
    )
    Rails.logger.info "\nAdmin user created with email: #{admin.email} and password: #{password}"
  end
end

def common_environment_seeds
  # these will run on dev and production mode. Review and test apps can have their own flows too
  create_or_verify_super_admin
end

def development_seeds
  return unless Rails.env.development?

  Rails.logger.info "\nCreating sample data for development environment..."
  create_categories_and_products
  Rails.logger.info "\nSample data created successfully"
end


def safe_seed(name)
  yield
rescue StandardError => e
  Rails.logger.error "\n[#{name}] seed failed: #{e.class} - #{e.message}"
  Rails.logger.error e.backtrace.join("\n")
  raise
end

safe_seed('Common Environment Seeds') { common_environment_seeds }
safe_seed('Development Seeds')   { development_seeds }
