class DropProductCategoryTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :product_categories
  end
end
