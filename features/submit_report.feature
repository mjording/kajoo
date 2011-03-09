@https://www.pivotaltracker.com/story/show/10880843
Feature: submit report
  As a user I want to report an issue
  so that I can encourage a solution

  Scenario: Submit Report

  Given I am logged in
  When I click submit report
  Then I should be on the submit new report page
  When I fill in required fields
  And I press submit
  Then I should be on the report page
  And I should see "report submitted"
