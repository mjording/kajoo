class SolutionVote < Vote
  belongs_to :solution
end
# == Schema Information
#
# Table name: votes
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  issue_id    :integer
#  solution_id :integer
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

