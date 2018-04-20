# == Schema Information
#
# Table name: units
#
#  id             :integer          not null, primary key
#  owner_id       :integer
#  unit_no        :string
#  street1        :string
#  street2        :string
#  city           :string
#  state          :string
#  zip_code       :string
#  room_count     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  calendar_label :string(7)
#

class Unit < ApplicationRecord

	belongs_to :owner, ->{owner}, class_name: 'User', optional: true
	has_many :bookings, dependent: :destroy
	has_many :expenses, dependent: :destroy

	def display_name
		unit_no
	end
	
end
