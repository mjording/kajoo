class Report < ActiveRecord::Base  
  #versioned
  mount_uploader :report_image, ReportImageUploader
  belongs_to :user
  belongs_to :issue
#  before_validation :geocode, :reverse_geocode
   
  validates_presence_of :user, :title, :description
  #acts_as_taggable_on :categories  
  #def geocoded?
    #return !location.nil?
  #end
  
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
  def categories
    if tags
      tags.split.map{|tag|tag.strip.gsub(',','')}.flatten
    else
      []
    end
  end
  #def address_with_city_and_state
    #return "#{address}, #{SITE['city_name']}, #{SITE['state_name']}, #{SITE['country_name']}"
  #end

  #geocode if lat/lon empty and address not empty. Address -geocode-> Lat/Lon -reverse_geocode-> Location (i.e. fully resolved address)
  #def geocode
    #if(address.nil? && !(lat.nil? || lon.nil?))
      #puts "Geocoding for location '#{address}'"
      #begin
        #super
      #rescue Exception => e
        #puts("Couldn't geocode '#{location}': #{e.message}")
        #puts e.backtrace
      #end
    #end
  #end
  
  #reverse geocode if location empty and lat/lon not empty
  #def reverse_geocode
    #if(!(lat.nil? || lon.nil?))
    #puts "Reverse geocoding for location '#{lat}, #{lon}'"
      #begin
        #super
      #rescue Exception => e
        #puts("Couldn't reverse-geocode '#{lat}, #{lon}': #{e.message}")
        #puts e.backtrace
      #end
    #end
  #end

end



# == Schema Information
#
# Table name: reports
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  title          :string(255)
#  description    :text
#  lat            :float
#  lon            :float
#  radius         :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  issue_id       :integer(4)
#  tags           :string(255)
#  address        :text
#  ip_address     :string(255)
#  location       :text
#  city           :string(255)
#  state          :string(255)
#  country_code   :string(255)
#  country_name   :string(255)
#  street_address :string(255)
#  zipcode        :string(255)
#

