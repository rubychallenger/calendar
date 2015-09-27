class AddOverviewToTitle < ActiveRecord::Migration
  def change
    add_column :titles, :overview, :text
  end
end
