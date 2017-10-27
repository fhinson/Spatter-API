class AddParamsToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_city, :string
    add_column :games, :game_state, :string
    add_column :games, :game_arena, :string
  end
end
