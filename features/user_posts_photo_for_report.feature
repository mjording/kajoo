@https://www.pivotaltracker.com/story/show/10910103
Feature: User posts photo for report
  As a user I want to post photo evidence of an issue to the issue report
  so that visitors and users empathize with and act on the issue

  Scenario: Post Photo Report

  Given I am a new, authenticated user
  When I go to new report page
  When I have completed the new report form
  And I fill in report_image with valid photo path
  And I press "create report"
  Then I should be on the report page
  And I should see "report submitted"
  And I should see a valid photo
