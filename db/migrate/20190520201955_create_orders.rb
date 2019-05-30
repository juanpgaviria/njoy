class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.integer :total, default: 0
      t.references :company, foreign_key: true
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
