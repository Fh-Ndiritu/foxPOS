namespace :generate_variants do
  desc "Generate variants for Product model"
  task product: :environment do
    Product.find_each do |product|
      next unless product.image.attached?

      product.image.variant(:icon).processed
      product.image.variant(:thumb).processed
    end
  end

  desc "Generate variants for Category model"
  task category: :environment do
    Category.find_each do |category|
      next unless category.image.attached?

      category.image.variant(:icon).processed
      category.image.variant(:thumb).processed
    end
  end
end
