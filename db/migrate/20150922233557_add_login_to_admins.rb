class AddLoginToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :login, :string
  end
end
