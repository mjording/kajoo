@https://www.pivotaltracker.com/story/show/10910609
Feature: User marks report fixed.
  As a user I want to mark a report as fixed.
  
  Background:
    Given 10 issues
  
  Scenario: Mark Report Fixed

    Given I am a new, authenticated user
    When I am on the home page
    Then I should see "Propose Solution"
    And I should see "Mark Resolved"
    When I follow "Mark Resolved"
    And I fill in the required fields
    And I press "submit"
    Then I should see "Resolved"
