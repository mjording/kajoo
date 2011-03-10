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

for i in 1..100
  puts "Creating report #{i}"
  report = user.reports.create({
    :title => "Report #{i}",
    :description => 'the bizzle amizzle, ma nizzl...',
  })
end
#issue = report.issue

#tpop.solutions.create({
#  :title => 'Shoot it in the face with a goddamn blunderbus',
#  :issue => issue
#})



