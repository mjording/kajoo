class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  has_many :votes, :class_name => 'SolutionVote'
  def add_vote_for_user(user)
    unless(user.votes_remaining > 0)
      throw VoteException.new('Not enough votes')
    end
    @vote = votes.create({:user => current_user})

    user.add_points(5)
  end
  
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

