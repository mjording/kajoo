@https://www.pivotaltracker.com/story/show/10897475
Feature: User earns 5 pts for closing an issue that stays closed
  As a user I want to be rewarded for closing an issue

  Background: 
    Given 10 issues

  @javascript
  Scenario: User earns 5 pts for closing an issue that stays closed

    Given I am a new, authenticated user
    When I am on the home page
    Then I should see "Propose Solution"
    And I should see "Mark Resolved"
    When I follow "Mark Resolved"
    And I fill in the required fields
    And I press "submit"
    Then I should see "Resolved"
    And I should gain 5 points
