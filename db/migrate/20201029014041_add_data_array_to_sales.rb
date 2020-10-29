class AddDataArrayToSales < ActiveRecord::Migration[6.0]
  def change
    remove_column :sales, :data
    add_column :sales, :data, :string, array: true, default: []
  end
end
