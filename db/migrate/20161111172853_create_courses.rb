class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :major_id
      t.integer :user_id

      t.timestamps
    end
  end
end
