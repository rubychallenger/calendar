class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string   "title"
      t.string   "image_url"
      t.text     "desc"
      
      t.timestamps null: false
    end
  end
end
