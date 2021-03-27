class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :price
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
