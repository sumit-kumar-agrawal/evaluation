class CreateOranges < ActiveRecord::Migration[6.1]
  def change
    create_table :oranges do |t|
      t.string :name
      t.string :variety
      t.timestamps
    end
  end
end
