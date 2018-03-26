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
#  rate                   :float(24)        default(0.0)
#  no_of_nights           :integer          default(1)
#  extra_fee              :float(24)        default(0.0)
#  cleaning_fee           :float(24)        default(0.0)
#  platform_service_fee   :float(24)        default(0.0)
#  total                  :float(24)        default(0.0)
#  total_without_cleaning :float(24)        default(0.0)
#  average_rate           :float(24)        default(0.0)
#  remark                 :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Booking < ApplicationRecord
	extend Enumerize

	belongs_to :unit, optional: true
	has_one :owner, through: :unit

	enumerize :platform, in: ['Airbnb', 'Booking.com', 'Agoda']
	enumerize :status, in: ['Completed', 'Confirmed', 'Pending', 'Cancelled']

	before_save :calculate_cost

	protected

	def calculate_total
		self.total = (rate*no_of_nights + extra_fee + cleaning_fee - platform_service_fee)
	end

	def calculate_total_without_cleaning
		self.total_without_cleaning = total - cleaning_fee
	end

	def calculate_average_rate
		self.average_rate = total_without_cleaning/no_of_nights
	end

	private

	def calculate_cost
		calculate_total
		calculate_total_without_cleaning
		calculate_average_rate
	end
end
