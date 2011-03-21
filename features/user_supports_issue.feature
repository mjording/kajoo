@https://www.pivotaltracker.com/story/show/10897017 @sxsw
Feature: User supports issue
  As a user I want to easily become a unique kajoo user
  so that I can quickly participate

  Scenario: User supports issue

  Given I am a new, authenticated user
  When I am at an issue page
  Then I should see "Support this"
  When I press "Support this"
  Then I should see "2 Support this"
