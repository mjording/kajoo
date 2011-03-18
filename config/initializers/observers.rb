Kajoo::Application.configure do
  config.active_record.observers = :report_observer
end
