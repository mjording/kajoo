Fabricator :user_achievement do
  user! {|user_achievement| Fabricate(:user, :achievements => [user_achievement])}
end
