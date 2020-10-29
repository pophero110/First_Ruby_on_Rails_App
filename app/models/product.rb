class Product < ApplicationRecord
  belongs_to :category
  validates :expiration_date, presence: true
  validates :quantity_of_box, presence: true
  validates :quantity_per_box, presence: true
  validates_uniqueness_of :name
  validates_uniqueness_of :foreign_name
  validates_uniqueness_of :barcode
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
