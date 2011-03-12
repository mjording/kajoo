Given 'I am signed in' do
  @me ||= Fabricate(:user)
  Given %(I am on the sign in page)
  When %(I fill in "Email" with "#{@me.email}")
  And %(I fill in "Password" with "#{@me.password}")
  And %(I press "Sign in")
end

When /^I sign out$/ do
  visit destroy_member_session_path
end


