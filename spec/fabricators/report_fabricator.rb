Fabricator :report do
  title 'dead animal'
  description 'Lorizzle ipsizzle dolor the bizzle amizzle, ma nizzle adipiscing elit. Nullam sapien velit, gangsta volutpizzle, pot black, gravida vizzle'
  user! {|report| Fabricate(:user, :reports => [report])}
  issue! {|report| Fabricate(:issue, :reports => [report])}
end
