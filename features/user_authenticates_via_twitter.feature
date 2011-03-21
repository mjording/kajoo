@https://www.pivotaltracker.com/story/show/10880591 @alpha
Feature: User authenticates via twitter
  As a user I want to easily become a unique kajoo user
  so that I can quickly participate

  Scenario: User authenticates via twitter

  When I am on the home page
  Then I should see "Sign Up"
  When I follow "Sign Up"
  Then i should be redirected to twitter to authorize
