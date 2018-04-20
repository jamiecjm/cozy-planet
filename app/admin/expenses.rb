# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  category_id :integer
#  unit_id     :integer
#  date        :date
#  description :string
#  amount      :float            default(0.0)
#  discount    :float            default(0.0)
#  no_of_items :integer          default(1)
#  total       :float            default(0.0)
#  remark      :text
#  claimed     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_expenses_on_category_id  (category_id)
#

ActiveAdmin.register Expense do

	permit_params :category_id, :unit_id, :date, :description, :amount,
	:discount, :no_of_items, :remark, :claimed

	active_admin_import timestamps: true

end
