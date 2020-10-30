class AddIsConfirmToProductList < ActiveRecord::Migration[6.0]
  def change
    add_column :product_lists, :is_confirm, :boolean
  end
end
