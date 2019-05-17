class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.references :category, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
