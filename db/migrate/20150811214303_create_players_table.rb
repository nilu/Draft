class CreatePlayersTable < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :name_brief
      t.string :sport
      t.string :position
      t.integer :age
      t.float :avg_pos_age_diff
      t.timestamps
    end
  end
end
