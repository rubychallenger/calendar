class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string   "title"
      t.string   "image_url"
      t.text     "desc"
      t.string   "who_added"
      
      t.timestamps null: false
    end
  end
end
