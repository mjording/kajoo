class UserAchievement < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: user_achievements
#
#  id          :integer(4)      not null, primary key
#  achievement :string(255)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

