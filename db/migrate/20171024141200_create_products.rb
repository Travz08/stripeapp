class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.text :image_data
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
