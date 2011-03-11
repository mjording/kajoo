class Issue < ActiveRecord::Base
  #versioned

  has_many :reports
  has_many :comments #XXX unused
  has_many :votes, :class_name => 'IssueVote'
  has_many :supporters, :through => :votes, :class_name => 'User', :uniq => true  
  has_one :resolver, :class_name => 'User'
  
  #validates_presence_of :reports
  
#  after_validation :reverse_geocode
  before_save :set_resolved_at
  
  def self.find_similar(report)
    similar = self.near([report.lat, report.lon], 1)
  end
    
  def add_vote_for_user(user)
    
    unless(user.votes_remaining > 0)
      throw Exception.new('Not enough votes')
    end
    
    @vote = votes.create({:user => user})
    
    self.vote_count += 1
    
    user.add_points(5)
  end
  
  protected
  
    #update fields when issue gets resolved
    def set_resolved_at
      if(resolved && resolved_at.nil?)
        resolved_at = Time.now.to_datetime
        resolver = current_user
      end
    end
  
end


# == Schema Information
#
# Table name: issues
#
#  id             :integer         not null, primary key
#  title          :string(255)
#  description    :text
#  lat            :float
#  lon            :float
#  radius         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  address        :string(255)
#  resolved       :boolean
#  ip_address     :string(255)
#  location       :text
#  city           :string(255)
#  state          :string(255)
#  country_code   :string(255)
#  country_name   :string(255)
#  street_address :string(255)
#  zipcode        :string(255)
#  vote_count     :integer         default(0)
#

