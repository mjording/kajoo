class Comment < ActiveRecord::Base
  belongs_to :issue
end


# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  issue_id   :integer(4)
#  text       :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

