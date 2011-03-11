Given 'I am signed in' do
  @me ||= Fabricate(:member)
  Given %(I am on the sign in page)
  When %(I fill in "Email" with "#{@me.email}")
  And %(I fill in "Password" with "#{@me.password}")
  And %(I press "Sign in")
end

Given /^I am signed in as the following member:$/ do |table|
  Given "the following member:", table
  And 'I am signed in as that member'
end

Given /^I am signed in as that member$/ do
  @me = @member
  Given 'I am signed in'
end

When /^I sign in as that member$/ do
  @me = @member
  When 'I sign out'
  And 'I am signed in'
end

When /^I sign in as another member$/ do
  @me = nil
  And 'I am signed in'
end

When /^I sign in as that space owner$/ do
  @me = @space_owner
  Given 'I am signed in'
end

When /^I sign out$/ do
  visit destroy_member_session_path
end


