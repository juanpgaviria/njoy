class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :names, limit: 100
      t.string :last_names, limit: 100
      t.string :address
      t.string :state
      t.string :city
      t.string :identification
      t.string :phone, limit: 100
      t.string :email, limit: 100
      t.date :birthday
      t.date :start_date
      t.binary :password
      t.references :company, foreign_key: true
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
