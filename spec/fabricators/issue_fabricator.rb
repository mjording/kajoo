Fabricator :issue do
  creator! {|issue| Fabricate(:user, :issues => [issue])}
  lat SITE['lat'] + Random.new.rand(1..10)
  lon SITE['lon'] + Random.new.rand(1..10)

end
Fabricator :issue_with_report, :from => :issue do
  reports!(:count => 1) { |report,i| Fabricate(:report, :issue => issue) }
end

Fabricator :resolved_issue, :class_name => Issue do
  creator! {|issue| Fabricate(:user, :issues => [issue])}
  lat SITE['lat'] + Random.new.rand(1..10)
  lon SITE['lon'] + Random.new.rand(1..10)
  resolved true
  resolved_at Time.now.to_datetime - 21.days
end
