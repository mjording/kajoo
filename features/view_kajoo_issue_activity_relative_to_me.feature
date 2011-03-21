@https://www.pivotaltracker.com/story/show/10910427
Feature: View kajoo issue activity relative to me
  As a user I want to view kajoo issue activity relative to me
  so that I can support and solve issues

  Scenario: User views kajoo relative issue activity

  Given I am a new, authenticated user
  When I am on the home page
  Then I should see 5 issues that are near my location
