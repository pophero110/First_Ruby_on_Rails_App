class Product < ApplicationRecord
  belongs_to :category

  def self.filter(params)
    if params.length > 3
      puts "filtered"
      params.slice(0, params.length - 3)
      products = Category.find_by(name: "Frozen").products
      return products
    else
      puts "aall"
      products = Product.all
      return products
    end
  end
end
