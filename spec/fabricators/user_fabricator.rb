Fabricator :user do
  name 'mjording'
  email { Fabricate.sequence(:email) { |i| "mjording#{i}@kajoo.org" } }
  password '123456'
  password_confirmation '123456'
end
