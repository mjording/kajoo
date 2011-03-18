class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue
  validates_presence_of :title, :description

  has_many :votes, :class_name => 'SolutionVote'
  def create_action
    :suggested_solution
  end
  def add_vote_for_user(user)
    @vote = votes.create({:user => user})

    user.add_points_for_action(:vote_on_solution)

    #user.add_points(5)
    user.save! 
  end
  
end


# == Schema Information
#
# Table name: solutions
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  user_id    :integer(4)
#  issue_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

