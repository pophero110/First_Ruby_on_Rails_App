class AddProductIdToProductHistory < ActiveRecord::Migration[6.0]
  def change
    add_column :product_histories, :product_id, :int
  end
end
