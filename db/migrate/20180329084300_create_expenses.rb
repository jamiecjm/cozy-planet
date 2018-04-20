class CreateExpenses < ActiveRecord::Migration[5.1]
  def up
    create_table :expenses do |t|
    	t.integer	:category_id
    	t.integer	:unit_id
    	t.date	:date
    	t.string	:description
    	t.float	:amount, default: 0
    	t.float	:discount, default: 0
    	t.integer	:no_of_items, default: 1
    	t.float :total, default: 0
    	t.text	:remark
    	t.boolean :claimed, default: false
      t.timestamps
    end

    add_index :expenses, :category_id
  end

  def down
  	drop_table :expenses
  end
end
