class CreateTransaktions < ActiveRecord::Migration[5.2]
  def change
    create_table :transaktions do |t|
      t.integer :quantity
      t.integer :kind, default: 0
      t.references :employee, foreign_key: true
      t.references :company, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
