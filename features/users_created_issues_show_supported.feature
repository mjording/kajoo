@https://www.pivotaltracker.com/story/show/11314075
Feature: Users created issues show supported
  As a user issues I've created should show supported
  so I see what can be supported

  Scenario: Users created issues show supported


  Given I am a new, authenticated user
  And have created unresolved issues
  When I go to the dashboard
  And select a unresolved issue of mine
  Then I should see "Supported"
