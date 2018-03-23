class AddWelcomeAtToUser < ActiveRecord::Migration[5.1]
  def up
  	add_column :users, :welcomed_at, :datetime
  end

  def down
  	remove_column :users, :welcomed_at
  end
end
