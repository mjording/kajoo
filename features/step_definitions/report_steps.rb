Given /^I have completed the new report form$/ do
  steps %Q{
    And I fill in the following:
      | Title                     | Trash/Bulk Pick-ups                       |
      | Description               | Boards and other bulk trash in alleyway between Conrad St \u0026 Redwood Avenue |
      | Tags                      | Trash                             |
      | Address                   | 1904 Redwood Ave Richmond, VA     |
  }
end

Given /^I am on a resolved report page$/ do
  @report ||= Fabricate(:report, :resolved => true)
  Given %(I am on the report page)
end

