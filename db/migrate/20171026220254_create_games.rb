class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :team1_name
      t.string :team2_name
      t.string :team1_city
      t.string :team2_city
      t.datetime :date

      t.timestamps null: false
    end
  end
end
