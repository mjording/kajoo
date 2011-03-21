Fabricator :issue do
  creator! {|issue| Fabricate(:user, :issues => [issue])}
  lat SITE['lat'] + Random.new.rand(1..10)
  lon SITE['lon'] + Random.new.rand(1..10)

end
