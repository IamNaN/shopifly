class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :cartable, polymorphic: true, null: false
      t.references :cart, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
