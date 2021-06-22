class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :guardian_name, null: false
      t.string :phone_number, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
