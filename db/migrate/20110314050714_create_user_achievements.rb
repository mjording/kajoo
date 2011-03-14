class CreateUserAchievements < ActiveRecord::Migration
  def self.up
    create_table :user_achievements do |t|
      t.string :achievement
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_achievements
  end
end
