class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.integer :quantity
      t.references :product, foreign_key: true
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
