class CreateProductLists < ActiveRecord::Migration[6.0]
  def change
    create_table :product_lists do |t|
      t.timestamps
      t.text :products, array: true, default: []
    end
  end
end
