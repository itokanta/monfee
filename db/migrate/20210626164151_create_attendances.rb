class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|

      t.timestamps
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :mday, null: false
      t.integer :fee, null:false
      t.references :student, foreign_key: true

    end
  end
end
