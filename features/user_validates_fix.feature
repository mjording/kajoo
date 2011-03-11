@https://www.pivotaltracker.com/story/show/10910747
Feature: User validates fix
  As a user I want to validate a resolved report.

  Scenario: Mark Report Fixed

  Given I am logged in
  And I am on a resolved report page
  When I click the validate fix button
  Then I should see "Congratulations, your issue is solved"
