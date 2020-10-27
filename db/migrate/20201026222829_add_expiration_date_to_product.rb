class AddExpirationDateToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :expiration_date, :datetime
  end
end
