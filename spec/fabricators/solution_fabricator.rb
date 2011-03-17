Fabricator :solution do
  title 'fix it'
  description 'Pellentesque rizzle tortizzle. Sizzle erizzle. Ma nizzle at dolor dapibus suscipit. Mah nizzle black velit sizzle mammasay mammasa mamma oo sa.'
  issue! {|solution| Fabricate(:issue, :solution => solution)}
  user! {|solution| Fabricate(:user, :solutions => [solution])}
end
