@https://www.pivotaltracker.com/story/show/10910609
Feature: User marks report fixed.
  
  Background: Given 10 reports


  @javascript
  Scenario: Mark Report Fixed

    Given I am a new, authenticated user
    When I am at the issues page
    Then I should see "Propose Solution"
    And I should see "Mark Resolved"
    When I follow "Mark Resolved"
    And I fill in the required fields
    And I press "submit"
    Then I should see "Resolved"
