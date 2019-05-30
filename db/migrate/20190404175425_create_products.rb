class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.integer :price
      t.string :description
      t.string :brand
      t.references :category, foreign_key: true
      t.references :supplier, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
