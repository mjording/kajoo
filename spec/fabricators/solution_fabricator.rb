Fabricator :solution do
  issue! {|solution| Fabricate(:issue, :solution => solution)}
  user! {|solution| Fabricate(:user, :solutions => [solution])}
  
end
