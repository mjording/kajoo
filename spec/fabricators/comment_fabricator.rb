Fabricator :comment do
  issue! {|comment| Fabricate(:issue, :comments => [comment])}
end
