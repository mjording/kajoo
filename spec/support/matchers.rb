RSpec::Matchers.define :have_country do |expected|
  match do |actual|
    actual.any? { |a| a.abbr == expected }
  end

  failure_message_for_should_not do |actual|
    "Expected countries not to include '#{expected}' but does"
  end

  failure_message_for_should do |actual|
    "Expected countries to include '#{expected}' but does not"
  end
end

RSpec::Matchers.define :have_message_for do |expected|
  match do |actual|
    actual.any? { |a| a.subject == expected }
  end

  failure_message_for_should_not do |actual|
    "Expected messages not to include '#{expected.inspect}' but does"
  end

  failure_message_for_should do |actual|
    "Expected messages to include '#{expected.inspect}' but does not"
  end
end

