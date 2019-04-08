class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :phone
      t.string :identification
      t.string :contact_name
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
