@https://www.pivotaltracker.com/story/show/11417019
Feature: Issue resolved confirm queue
  As a user I want to  confirm an issue is solved
  so that issues cannot be swept under the rug

    Background:
      Given 1 resolved issue

    Scenario: User confirmes issue resolved

    Given I am logged in
    When I am on the home page
    Then I should see "Agree!"
    When I press "Agree!"
    Then I should see "Congratulations its fixed."
