class AddCountToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :count, :integer, default: 0
  end
end
