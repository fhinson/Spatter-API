namespace :schedule do
  task :generate => :environment do
    Game.delete_all
    f = File.read(Rails.root + "lib/tasks/schedule.json")
    f_json = JSON.parse(f)
    f_json["lscd"].each do |objects|
      objects["mscd"]["g"].each_with_index do |object, index|
        g = Game.new
        g.team1_name = object["h"]["tn"]
        g.team2_name = object["v"]["tn"]
        g.team1_city = object["h"]["tc"]
        g.team2_city = object["v"]["tc"]
        g.date = object["etm"]
        g.game_city = object["ac"]
        g.game_state = object["as"]
        g.game_arena = object["an"]
        g.save!
        puts (index+1).to_s + " Games Saved"
      end
    end
  end
end
