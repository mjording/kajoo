class Issue < ActiveRecord::Base
  has_many :reports
  has_many :votes, :class_name => 'IssueVote'
  has_many :supporters, :through => :votes, :class_name => 'User', :uniq => true
  
  def location_name
    return 'Downtown Austin'
  end
  
  def add_vote_for_user(user)
  
    unless(user.votes_remaining > 0)
      throw Exception.new('Not enough votes')
    end
  
    @vote = votes.create({:user => user})
    
    user.add_points(5)
    
  end
  
end

# == Schema Information
#
# Table name: issues
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  lat         :float
#  lon         :float
#  radius      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  report_id   :integer
#

