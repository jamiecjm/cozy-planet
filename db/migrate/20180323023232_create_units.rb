class CreateUnits < ActiveRecord::Migration[5.1]
  def up
    create_table :units do |t|
    	t.integer	:owner_id
    	t.string	:unit_no
    	t.string	:street1
    	t.string	:street2
    	t.string	:city
    	t.string	:state
    	t.string	:zip_code
    	t.integer	:room_count
      t.timestamps
    end
  end
  def down
  	drop_table :units
  end
end
