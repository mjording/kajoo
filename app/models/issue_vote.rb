class IssueVote < Vote
  belongs_to :issue
end

# == Schema Information
#
# Table name: votes
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  issue_id    :integer(4)
#  solution_id :integer(4)
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

