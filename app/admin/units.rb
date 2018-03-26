# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  unit       :string(255)
#  street1    :string(255)
#  street2    :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip_code   :string(255)
#  room_count :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

ActiveAdmin.register Unit do

	permit_params :owner_id, :unit_no, :street1, :street2, :city, :state, :zip_code, :room_count, :calendar_label

	menu false
	
	batch_action :destroy, false

	active_admin_import timestamps: true

	form do |f|
		inputs do
			input :owner, collection: User.owner
			input :unit_no
			input :street1
			input :street2
			input :city
			input :state
			input :zip_code
			input :room_count
			input :calendar_label, as: :color_picker
		end
		actions
	end

end
