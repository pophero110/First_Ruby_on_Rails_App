class AddConfirmBooleanToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :is_confirm, :boolean
  end
end
