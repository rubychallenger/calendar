class RemoveLoginFromAdmin < ActiveRecord::Migration
  def change
  	remove_column :admins, :login
  	remove_column :admins, :username
  end
end
