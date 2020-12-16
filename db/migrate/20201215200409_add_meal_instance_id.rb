class AddMealInstanceId < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :instance_id, :int
  end
end
