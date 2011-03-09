class Issue < ActiveRecord::Base
  has_many :reports
  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :lat, :lon
  def self.find_similar(report)
    similar = self.near([report.lat, report.lon], 3)
    similar  
  end

  after_validation :reverse_geocode
  
end
