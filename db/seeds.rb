# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
  #reports
   

user = User.create({
  :email => "admin@kajoo.org", 
  :password => Devise.friendly_token[0,20],
  :avatar_url => 'http://a1.twimg.com/profile_images/1188388501/Photo_on_2010-12-10_at_15.09__4.jpg', 
  :name => 'kajooit', 
  :twitter_username => 'kajooit' 
})



fixture_issues = JSON.load(File.read(File.join(Rails.root, 'db', 'issues.json')))
fixture_issues.each_with_index do|fixture_issue,i|
  #issue = Issue.find_by_title( fixture_issue['summary'])
  #near_report = Issue   
  inputtext = fixture_issue['summary']+' '+(fixture_issue['description'].blank? ? fixture_issue['summary'] : fixture_issue['description'])
  categories = inputtext.summarize(:topics => true).last.split(',')
  similar = Issue.tagged_with(categories).near([fixture_issue["lat"],fixture_issue["lon"]],1)
  issue = similar.first
  puts "found issue #{issue.id}"  unless issue.nil? 

  issue ||= Issue.new({
        #:title => fixture_issue['summary'],
        :description => inputtext,
        :location => fixture_issue['address'],
        :lat => fixture_issue["lat"],
        :lon => fixture_issue["lng"],
        :creator => user
    })

  report = user.reports.build({
    :description => inputtext,
    :location => fixture_issue['address'],
    :lat => fixture_issue["lat"],
    :lon => fixture_issue["lng"],
    :issue => issue 
  })
  #issue.reports.build()
   report.save!
  
  puts "created report #{report.id}"

  #issue.reports.create({:title => issue.title, :description => issue.description, :lat => issue.lat, :lon => issue.lon, :location => issue.location, :user => issue.creator})
  #report = issue.reports.create({:title => issue.title, :description => issue.description, :lat => issue.lat, :lon => issue.lon, :location => issue.location, :user => issue.creator})

end
#issues = JSON.load(File.new('issues.json'))
#issue = report.issue

#tpop.solutions.create({
#  :title => 'Shoot it in the face with a goddamn blunderbus',
#  :issue => issue
#})



