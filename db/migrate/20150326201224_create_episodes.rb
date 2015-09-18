class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :season
      t.integer :number
      t.integer :title_id
      t.datetime :airdate
      t.string :wday

      t.timestamps null: false
    end
  end
end
