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

batch_action :destroy, false

active_admin_import timestamps: true

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

end
