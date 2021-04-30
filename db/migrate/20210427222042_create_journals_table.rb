class CreateJournalsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :journals do |t|
      t.string :title 
      t.datetime :date
      t.text :entry
      t.string :mood 
      t.boolean :lucid?
    end
  end
end
