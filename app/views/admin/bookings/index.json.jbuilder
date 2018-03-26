if params['calendar_type'] == 'default'
	json.array!(@bookings) do |booking|
	  json.id booking.id
	  json.title booking.unit.unit_no
	  json.description booking.guest
	  json.start booking.check_in
	  json.end booking.check_out
	  json.url admin_booking_url(booking)
	end
elsif params['calendar_type'] == 'list_view'
	json.array!(@bookings) do |booking|
	  json.id booking.id
	  json.title booking.unit.unit_no + ' Check In'
	  json.description booking.guest
	  json.start booking.check_in
	  json.end booking.check_in + 1.hour
	  json.url admin_booking_url(booking)
	end +
	json.array!(@bookings) do |booking|
	  json.id booking.id
	  json.title booking.unit.unit_no + ' Check Out'
	  json.description booking.guest
	  json.start booking.check_out
	  json.end booking.check_out + 1.hour
	  json.url admin_booking_url(booking)
	end
else
	json.array!(@bookings) do |booking|
	  json.extract! booking, 
	  	:id,
		:unit_id,
		:platform,
		:status,
		:guest,
		:check_in,
		:check_out,
		:rate,
		:no_of_nights,
		:extra_fee,
		:cleaning_fee,
		:platform_service_fee,
		:total,
		:total_without_cleaning,
		:average_rate,
		:remark,
		:created_at,
		:updated_at
	end	
end