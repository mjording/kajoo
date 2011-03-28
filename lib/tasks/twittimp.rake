require 'open-uri'

RAILS_ENV=ENV['RAILS_ENV'] if ENV['RAILS_ENV'] and '' != ENV['RAILS_ENV']
Rake::Task['environment'].invoke

namespace :open311 do

  desc 'import from twitter'
  task :twitter_import do
    puts "configs #{Twitter.options}" 
    puts "the rake task did something#{Twitter.user}"
    hashtags = ["kajoo","kajoonyc","kajooaustin","kajoomadison","nyckajoo","austinkajoo","madisonkajoo"]
    twittqueue = []
    hashtags.each do|ht|
      twittqueue << Twitter::Search.new.hashtag(ht).hashtag("fixit").per_page(1000).fetch
    end
    twittqueue.flatten.each do |twit|
      from = Twitter.user(twit.from_user)
      break unless twit.geo || twit.place
      user = User.find_by_email("#{from.id}@kajoo.org") || 
        User.new({
          :email => "#{from.screen_name}@kajoo.org",
          :password => Devise.friendly_token[0,20],
          :avatar_url => from.profile_image_url,
          :name => from.name,
          :twitter_username => from.screen_name
        })
      puts "User #{user.email} in play"
      user.save
      puts "user saved #{user.id}"

      report_urls = twit.text.scan(/(http:\/\/\S+)/)
      report = user.reports.build(:description => twit.text)
      hits = hashtags.delete('kajoo').map{|h|"##{h}"}
      hits.each{|h|report.description = report.description.gsub(h,'')}
      report.description.gsub('#kajoo','')
      report_urls.each do|report_url|
        resp = Net::HTTP.get URI.parse(report_url)
        if resp.class == String && resp.scan(/http:\/\/\S+\.(JPG|jpg|PNG|png|GIF|gif|JPEG|jpeg)/)
          report.description.delete(report_url)
          report.report_image = report_url
        end
      end
      if twit.geo && twit.geo.type == "Point"
        twit.geo.coordinates.map{|coord|report.lat = coord[0]; report.lon = coord[1]}
      else
        loc = Twitter.client.get("http://api.twitter.com/1/geo/id/#{twit.place.id}")
        if loc.place_type == "neighborhood"
          coord = Geocoder::Calculations.geographic_center loc.geometry.coordinates.first
          report.lat = coord[0]
          report.lon = coord[1]
        elsif loc.geometry.coordinates.first.class == Array && loc.geometry.coordinates.first.uniq.count == 1
          report.lat = loc.geometry.coordinates.first.uniq.first[0]
          report.lon = loc.geometry.coordinates.first.uniq.first[1]
        else
          report.lat = loc.geometry[0]
          report.lon = loc.geometry[1]
        end
      end
      puts "report built #{report.description}"
      if rereport = Report.find_by_description(report.description)
        puts "#{rereport.id} attempted again"
      else
        report.save
      end
    end  
  end
end

