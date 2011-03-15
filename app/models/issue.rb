class Issue < ActiveRecord::Base
  #versioned

  has_many :reports
  has_many :comments #XXX unused
  has_many :votes, :class_name => 'IssueVote'
  has_many :supporters, :through => :votes, :class_name => 'User', :uniq => true, :source => 'user'
  has_one :resolver, :class_name => 'User'
  belongs_to :creator, :class_name => 'User'
  has_one :solution
  has_many :solution_votes
  has_many :suggestions, :through => :solution_votes, :class_name => 'Solution', :uniq => true, :source => 'solution'
  #validates_presence_of :reports
  #acts_as_taggable_on :categories 
  accepts_nested_attributes_for :reports, :allow_destroy => true
  
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  #_with_city_and_state, :latitude  => :lat, :longitude => :lon
   
  reverse_geocoded_by :lat, :lon do |obj, geo|
  #, :address => :location 
    obj.city = geo.city
    obj.zipcode = geo.postal_code
    obj.country_name = geo.country
    obj.country_code = geo.country_code 
    obj.street_address = geo.address
    obj.lat = geo.latitude
    obj.lon = geo.longitude
  end

#  after_validation :reverse_geocode
  before_save :set_resolved_at
  
  def self.find_similar(report)
    self.find_near_report(report)
  end
  def self.find_near_report(report)
    similar = self.near([report.lat, report.lon], 1)
  end
  def self.find_similar_tags_for_report(report)
    reports = self.find_near_report.map{|issue|issue.reports}
    reports.map{|r|r.categories}.flatten
    similar.map{|s|s.reports.map{|r|r.categories}.flatten}.flatten.include? report.categories
    similar 
  end
    
  def add_vote_for_user(user)
    
    unless(user.votes_remaining > 0)
      throw VoteException.new('Not enough votes. Please return in a few hours to vote on more issues.')
    end
    
   if(user.has_voted_for_issue?(self))
     throw VoteException.new('You cant vote twice for the same issue');
   end
 
   @vote = votes.create({:user => user})
    
    self.vote_count += 1
    
    user.add_points_for_action(:vote_on_issue)
    
    user.save!
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

