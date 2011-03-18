Fabricator :issue do
  creator! {|issue| Fabricate(:user, :issues => [issue])}
end
