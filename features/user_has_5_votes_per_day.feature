@https://www.pivotaltracker.com/story/show/10896985
Feature: User has 5 votes per day
  As a user I want participation limits so that I can be easily rewarded for positive participation

  Scenario: User has 5 votes per day

  Given I am logged in for the first time today
  When I am on the home page
  Then I should see 5 Votes Left
  And I should see "Support This"
  When I press "Support This"
  Then I should see 4 Votes Left
  When 24 hours 1 minutes pass
  Then I should see 5 Votes Left
