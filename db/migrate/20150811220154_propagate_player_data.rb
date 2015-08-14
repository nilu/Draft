class PropagatePlayerData < ActiveRecord::Migration
  def up
    puts "Propagating player data from CBS API"
    sports = ['baseball', 'basketball', 'football']

    sports.each do |sport|
      puts "\t Propagating #{sport} players ... "
      # imported files from CBS's API
      file = File.read("./app/assets/javascripts/#{sport}.json")
      players = JSON.parse(file)['body']['players']
      players.each do |player|

        # Note / Todo: It is better practice to write model statements in Raw SQL.
        # I'm writing it like this because I am aware Draft uses Postgres and did not 
        # want to cause confusion. (Plus imo this is neater.)
        new_player = Player.new(
          first_name: player['firstname'],
          last_name: player['lastname'],
          sport: sport,
          position: player['position'],
          age: player['age'],
        )
        new_player.name_brief = new_player.create_name_brief
        new_player.save
      end
    end
  end

  def down
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE players")
  end
end
