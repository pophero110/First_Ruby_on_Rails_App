class Category < ApplicationRecord
  validates_uniqueness_of :name
  has_many :article_categories
  has_many :articles, through: :article_categories
  has_many :products
end
