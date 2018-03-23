class CreateBookings < ActiveRecord::Migration[5.1]
  def up
    create_table :bookings do |t|
    	t.integer	:unit_id
    	t.string	:platform
    	t.string	:status
    	t.string	:guest
    	t.datetime	:check_in
    	t.datetime	:check_out
    	t.float	:rate, default: 0
    	t.integer	:no_of_nights, default: 1
    	t.float	:extra_fee, default: 0
    	t.float	:cleaning_fee, default: 0
    	t.float	:platform_service_fee, default: 0
    	t.float	:total, default: 0
    	t.float	:total_without_cleaning, default: 0
    	t.float	:averate_rate, default: 0
    	t.text	:remark
      t.timestamps
    end
  end

  def down
  	drop_table :bookings
  end
end
