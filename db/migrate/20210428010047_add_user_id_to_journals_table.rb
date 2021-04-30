class AddUserIdToJournalsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :journals, :user_id, :integer
  end
end
