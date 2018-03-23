# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  unit_no    :string(255)
#  street1    :string(255)
#  street2    :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip_code   :string(255)
#  room_count :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ApplicationRecord

	belongs_to :owner, ->{owner}, class_name: 'User', optional: true
	has_many :bookings, dependent: :destroy

	def display_name
		unit_no
	end
	
end
