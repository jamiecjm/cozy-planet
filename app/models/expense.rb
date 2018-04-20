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

class Expense < ApplicationRecord

	belongs_to :unit

	before_save :calc_total

	protected

	def calc_total
		self.total = (amount-discount)*no_of_items
	end
end
