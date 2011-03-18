require 'spec_helper'

describe IssueVote do
  it { should belong_to(:issue) }
end
