class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :employee, foreign_key: true
      t.time :end_time
      t.time :start_time
      t.timestamps
    end
  end
end
