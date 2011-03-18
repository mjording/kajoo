Fabricator :report do
  issue! {|report| Fabricate(:issue, :reports => [report])}
  user! {|report| Fabricate(:user, :reports => [report])}
  title 'dead animal'
  description 'Lorizzle ipsizzle dolor the bizzle amizzle, ma nizzle adipiscing elit. Nullam sapien velit, gangsta volutpizzle, pot black, gravida vizzle'
end
