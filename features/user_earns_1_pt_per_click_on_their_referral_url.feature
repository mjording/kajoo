@https://www.pivotaltracker.com/story/show/10897399
Feature: User earns 1 pt per click on their referral url
  As a user I want to gain a point for successful referals
  so that my influence is accounted for

  Scenario: Referral rewards

  Given I am not authenticated
  When I follow a valid referral link
  And I sign up
  Then the referral user should gain 1 point
