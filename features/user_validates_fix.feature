@https://www.pivotaltracker.com/story/show/10910747
Feature: User validates fix
  As a user I want to validate a resolved report.

  Scenario: Mark Issue Fixed

  Given I am a new, authenticated user
  And I am at a resolved issue page
  When I press "I agree"
  Then I should see "Congratulations, your issue is solved"
