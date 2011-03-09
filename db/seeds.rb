# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
tpop = User.create({
  :email => "tpop@twitter.com", 
  :password => Devise.friendly_token[0,20], 
  :avatar_url => 'http://a1.twimg.com/profile_images/1188388501/Photo_on_2010-12-10_at_15.09__4.jpg', 
  :name => 'mjording', 
  :twitter_id => '@twitter' 
})

tpop.reports.build({
  :title => "Remove the Monster Gator threat", 
  :description => "orizzle ipsizzle dolor the bizzle amizzle, ma nizzl..."  
})




