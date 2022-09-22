class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.text :interests
      t.text :image
      t.string :image_alt

      t.timestamps
    end
  end
end
