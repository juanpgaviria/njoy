class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.integer :number
      t.integer :pos_x
      t.integer :pos_y
      t.integer :width
      t.integer :height
      t.references :company, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
