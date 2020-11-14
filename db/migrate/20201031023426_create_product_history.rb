class CreateProductHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :product_histories do |t|
      t.integer :change_in_quantity
      t.timestamps
    end
  end
end
