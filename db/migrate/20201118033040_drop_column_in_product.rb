class DropColumnInProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :quantity_of_box
    remove_column :products, :quantity_per_box
  end
end
