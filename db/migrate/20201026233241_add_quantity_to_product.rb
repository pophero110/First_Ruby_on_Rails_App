class AddQuantityToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :quantity_of_box, :int
    add_column :products, :quantity_per_box, :int
    add_column :products, :quantity_in_total, :int
  end
end
