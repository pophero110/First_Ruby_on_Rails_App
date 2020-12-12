class CreateShipment < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.timestamps
      t.text "products", default: [], array: true
      t.boolean "is_received"
    end
  end
end
