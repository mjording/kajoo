Fabricator :user do
  name 'mjording'
  email { Fabricate.sequence(:email) { |i| "mjording#{i}@kajoo.org" } }
  password '123456'
  password_confirmation '123456'
  avatar_url 'http://a1.twimg.com/profile_images/1188388501/Photo_on_2010-12-10_at_15.09__4.jpg'
end
