Fabricator :user_token do
  user! {|user_token| Fabricate(:user, :user_tokens => [user_token])}
end
