Fabricator :issue_vote do
  issue! {|issue_vote| Fabricate(:issue, :votes => [issue_vote])}
end
