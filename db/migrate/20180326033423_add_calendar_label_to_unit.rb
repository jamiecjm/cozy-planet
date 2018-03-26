class AddCalendarLabelToUnit < ActiveRecord::Migration[5.1]
  def up
    add_column :units, :calendar_label, :string, limit: 7
  end

  def down
  	remove_column :units, :calendar_label
  end
end
