class Solution < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: solutions
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  user_id    :integer
#  issue_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

