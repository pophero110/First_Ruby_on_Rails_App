class Product < ApplicationRecord
  belongs_to :category
  validates :expiration_date, presence: true
  validates :quantity_of_box, presence: true
  validates :quantity_per_box, presence: true
  validates_uniqueness_of :barcode
  validates :barcode, length: { minimum: 12, maximum: 13 }
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

  def barcode=(value)
    if value.length == 12
      write_attribute(:barcode, value.insert(0, "0"))
    else
      write_attribute(:barcode, value)
    end
  end
end
