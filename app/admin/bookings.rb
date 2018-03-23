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
