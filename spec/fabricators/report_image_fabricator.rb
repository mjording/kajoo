ReportImage.class_eval do
  attr_accessor :temp_file
end

Fabricator :report_image do
  temp_file 'valid_report_image.jpg'
  after_build do |p|
    p.file = Rack::Test::UploadedFile.new("spec/fixtures/#{p.temp_file}")
  end
end
