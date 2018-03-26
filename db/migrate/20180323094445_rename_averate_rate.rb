class RenameAverateRate < ActiveRecord::Migration[5.1]
  def up
  	rename_column :bookings, :averate_rate, :average_rate
  end

  def down
  	rename_column :bookings, :average_rate, :averate_rate
  end
end
