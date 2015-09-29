class AddIpToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :ip, :string
  end
end
