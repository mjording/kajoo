@https://www.pivotaltracker.com/story/show/10880843
Feature: submit report
  As a user I want to report an issue
  so that I can encourage a solution

  Scenario: Submit Report

  Given I am a new, authenticated user
  Then I should be on the home page
  And I should see "Submit A Report"
  When I go to new report page
  Then I should be on the submit new report page
  Given I have completed the new report form
  And I press "Create Report"
  Then I should see "Report was successfully created"
