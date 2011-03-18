Fabricator :solution_vote do
  solution! {|solution_vote| Fabricate(:solution, :votes => [solution_vote])}
end
