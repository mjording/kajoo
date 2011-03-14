# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
user = User.create({
  :email => "tpop@twitter.com", 
  :password => Devise.friendly_token[0,20],
  :avatar_url => 'http://a1.twimg.com/profile_images/1188388501/Photo_on_2010-12-10_at_15.09__4.jpg', 
  :name => 'mjording', 
  :twitter_id => '@twitter' 
})

#report = tpop.reports.create({
#  :title => "Remove the Monster Gator threat",
#  :description => "orizzle ipsizzle dolor the bizzle amizzle, ma nizzl..."
#})
issues = JSON.load(File.read(File.join(Rails.root, 'db', 'issues.json')))
issues.each_with_index do|issue,i|
  puts "creating issue #{i}"
  issue = Issue.create({
    :title => issue['summary'],
    :description => issue['description'],
    :location => issue['address'],
    :lat => issue["lat"],
    :lon => issue["lng"],
    :created_by => user
  })
  issue.save!

  issue.reports.create({:title => issue.title, :description => issue.description, :lat => issue.lat, :lon => issue.lon, :location => issue.location, :user => user})
end
#issues = JSON.load(File.new('issues.json'))
#issue = report.issue

#tpop.solutions.create({
#  :title => 'Shoot it in the face with a goddamn blunderbus',
#  :issue => issue
#})



