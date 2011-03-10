class Comment < ActiveRecord::Base
  belongs_to :issue
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  issue_id   :integer
#  text       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

