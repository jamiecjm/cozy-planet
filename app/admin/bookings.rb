# == Schema Information
#
# Table name: bookings
#
#  id                     :integer          not null, primary key
#  unit_id                :integer
#  platform               :string(255)
#  status                 :string(255)
#  guest                  :string(255)
#  check_in               :datetime
#  check_out              :datetime
#  rate                   :float(24)
#  nights                 :integer
#  extra_fee              :float(24)
#  cleaning_fee           :float(24)
#  platform_service_fee   :float(24)
#  total                  :float(24)
#  total_without_cleaning :float(24)
#  averate_rate           :float(24)
#  remark                 :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

ActiveAdmin.register Booking do
permit_params :unit_id, :platform, :status, :guest, :check_in, :check_out, :rate, :no_of_nights, 
				:extra_fee, :cleaning_fee, :platform_service_fee, :remark

menu false

batch_action :destroy, false

active_admin_import timestamps: true

before_action do
	if params['as'] == 'calendar'
		params['per_page'] = Booking.count.to_s
	else
		params['per_page'] = nil
	end
end

index pagination_total: false do
	id_column
	column :unit
	column :platform
	column :status
	column :guest
	column :check_in
	column :check_out
	number_column :rate, as: :currency, unit: ''
	number_column 'Nights', :no_of_nights
	number_column :subtotal, as: :currency, unit: '' do |b|
		b.rate * b.no_of_nights
	end
	number_column :extra_fee, as: :currency, unit: ''
	number_column :cleaning_fee, as: :currency, unit: '' if current_user.operator?
	number_column :platform_service_fee, as: :currency, unit: ''
	if current_user.operator?
		number_column :total, as: :currency, unit: ''
		number_column :total_without_cleaning, as: :currency, unit: ''
	else
		number_column 'Total', :total_without_cleaning, as: :currency, unit: ''
	end
	number_column :average_rate, as: :currency, unit: ''
	column :remark
	actions
end

before_action do
	params['q'] = {} if params['q'].blank?
	if params['q']['status_eq'].blank?
		params['q']['status_not_eq'] = 'Cancelled'
	end	
	if params['as'] == 'report'
		if params['q']['year'].blank?
			params['q']['year'] = Date.current.year
		end
	elsif params['as'] == 'calendar'
		
	end
end

index as: :calendar, pagination_total: false, title: 'Calendar' do
	div class: 'calendar' do
		columns do
			column do
				div id: 'calendar'
			end
			column do
				div id: 'calendar-list_view'
			end
		end
	end
end

index as: :report, pagination_total: false, title: 'Reports' do
	columns do
		h1 number_to_currency(bookings.sum(:total_without_cleaning), unit: 'RM ', delimeter: ',')
		h3 "Earnings for " + "#{params['q']['month']} " + "#{params['q']['year']}"
		br
		column do
			months = Date::MONTHNAMES.compact.map {|m| ["#{m.to_date.strftime('%b')} #{params['q']['year']}", 0]}
			grouped_bookings = bookings.reorder(nil).group_by_month(:check_in, format: "%b %Y").sum(:total_without_cleaning)
			grouped_bookings = months.to_h.merge!(grouped_bookings){|k, old_v, new_v| old_v + new_v}
			grouped_bookings = grouped_bookings.map {|k,v| [k, v.round(2)]}
			column_chart grouped_bookings
		end
		br
		h2 "#{params['q']['month']} " + "#{params['q']['year']} details"
		table do
			tr do
				th 'Rate'
				td number_to_currency(bookings.sum(:rate), unit: 'RM ', delimeter: ',')
			end
			tr do
				th 'No. of Nights'
				td number_with_delimiter(bookings.sum(:no_of_nights))
			end
			tr do
				th 'Extra Fees'
				td number_to_currency(bookings.sum(:extra_fee), unit: 'RM ', delimeter: ',')
			end
			tr do
				th 'Cleaning Fees'
				td number_to_currency(bookings.sum(:cleaning_fee), unit: 'RM ', delimeter: ',')
			end
			tr do
				th 'Platform Service Fees'
				td number_to_currency(bookings.sum(:platform_service_fee), unit: 'RM ', delimeter: ',')
			end
		end
	end
end	

show do
	attributes_table do
		row :id
		row :unit
		row :platform
		row :status
		row :guest
		row :check_in
		row :check_out
		number_row :rate, as: :currency, unit: ''
		number_row 'Nights' do |b|
			b.no_of_nights
		end
		number_row :subtotal, as: :currency, unit: '' do |b|
			b.rate * b.no_of_nights
		end
		number_row :extra_fee, as: :currency, unit: ''
		number_row :cleaning_fee, as: :currency, unit: '' if current_user.operator?
		number_row :platform_service_fee, as: :currency, unit: ''
		if current_user.operator?
			number_row :total, as: :currency, unit: ''
			number_row :total_without_cleaning, as: :currency, unit: ''
		else
			number_row 'Total', as: :currency, unit: '' do |b| 
				b.total_without_cleaning
			end
		end
		number_row :average_rate, as: :currency, unit: ''
		row :remark
	end
	active_admin_comments
end

form do |f|
	inputs do
		input :unit
		input :platform
		input :status
		input :guest, label: 'Guest Name'
		input :check_in, as: :date_time_picker
		input :check_out, as: :date_time_picker
		input :rate, min: 0, step: :any
		input :no_of_nights, min: 1, step: 1
		input :extra_fee, min: 0, step: :any
		input :cleaning_fee, min: 0, step: :any
		input :platform_service_fee, min: 0, step: :any
		input :remark
	end

	actions
end

filter :year, as: :select, :collection => proc { 
	start_year = Booking.order('check_in asc').first&.check_in&.year
	start_year ||= Date.current.year
	end_year = Date.current.year
	(start_year..end_year).to_a.reverse 
}
filter :month, as: :select, :collection => Date::MONTHNAMES.compact
filter :unit, collection: proc {Unit.accessible_by(current_ability)}
filter :owner, if: proc{current_user.operator?}, collection: proc {User.owner}
filter :platform
filter :status
filter :guest

end
