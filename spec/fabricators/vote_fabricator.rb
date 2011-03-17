Fabricator :vote do
  user! {|vote| Fabricate(:user, :votes => [vote])}
end
