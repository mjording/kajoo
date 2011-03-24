Given /^I have completed the new report form$/ do
  steps %Q{
    And I fill in the following:
      | Description               | Trash/Bulk Pick-ups Boards and other bulk trash in alleyway between Conrad St \u0026 Redwood Avenue |
      | Address                   | 1904 Redwood Ave Richmond, VA     |
  }
end

Given /^I am at a resolved report page$/ do
  @report ||= Fabricate(:report, :resolved => true)
  Given %(I am on the report page)
end



Given /^I fill in report_report_image with valid photo path$/ do
   filename = "valid_report_image.jpg"
   path = File.expand_path(File.join('spec', 'fixtures', filename))

   When %{I fill in "report_image" with "#{path}"}
end

