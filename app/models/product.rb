class Product < ApplicationRecord
  belongs_to :category
  has_many :product_histories
  has_many :product_vendors
  has_many :vendors, through: :product_vendors

  def self.filter(params)
    if params.length > 3
      puts "filtered"
      params.slice(0, params.length - 3)
      products = Category.find_by(name: "Frozen").products
      return products
    else
      puts "all"
      products = Product.all
      return products
    end
  end

  def barcode=(value)
    if value.length == 12
      write_attribute(:barcode, value.insert(0, "0"))
    else
      write_attribute(:barcode, value)
    end
  end
end
