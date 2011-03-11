@https://www.pivotaltracker.com/story/show/10910609
Feature: User marks report fixed.
  As a user I want to mark a report as fixed.

  Scenario: Mark Report Fixed

  Given I am logged in
  And I am on an unresolved report page
  When I click the fixed button
  And I fill in the required fields
  And I press "mark as fixed"
  Then I should see "report is fixed"
