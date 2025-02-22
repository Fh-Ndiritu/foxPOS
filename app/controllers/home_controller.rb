class HomeController < ApplicationController
  def menu
    @products = Product.limit(10)
    @categories = Category.all
  end
end
