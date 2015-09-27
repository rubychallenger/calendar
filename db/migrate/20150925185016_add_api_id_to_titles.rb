class AddApiIdToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :Api_id, :string
  end
end
