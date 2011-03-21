@https://www.pivotaltracker.com/story/show/10897017 @sxsw
Feature: User supports issue
  As a user I want to easily become a unique kajoo user
  so that I can quickly participate

  Background: 
    Given 1 issue

  @javascript
  Scenario: User supports issue
    Given I am a new, authenticated user
    When I am on the home page
    Then I should see "Support this"
    When I follow "Support this"
    Then I should see "Supported!"
