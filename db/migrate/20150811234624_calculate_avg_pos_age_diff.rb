class CalculateAvgPosAgeDiff < ActiveRecord::Migration
  def up
    sports = ['baseball', 'basketball', 'football']

    sports.each do |sport|
      # Some players weren't given a position or age. Ignore these players.
      positions = Player.where('sport = ? AND age != ? AND position != ?', sport, 0, '').group_by(&:position)
      positions.each do |position|
        abbr = position[0]
        players = position[1]
        total_age = 0

        players.each do |player|
          total_age += player.age
        end

        avg_pos_age = total_age.to_f / players.count

        players.each do |player|
          player.avg_pos_age_diff = (player.age - avg_pos_age).round(0)
          player.save!
        end
      end
    end
  end

  def down
    Player.update_all avg_pos_age_diff: nil
  end
end
