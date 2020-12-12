class CreateVendors < ActiveRecord::Migration[6.0]
  def change
    create_table :vendors do |t|
      t.timestamps
      t.string :name
      t.string :email
      t.string :contact_number
      t.text :address
      t.string :language_preference
    end
  end
end
