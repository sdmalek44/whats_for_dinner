class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :keyword
      t.integer :max_time
      t.text :allergies

      t.timestamps
    end
  end
end
