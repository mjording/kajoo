Given 'I am at an unresolved issue page' do
  @issue ||= Fabricate(:issue)
  Given %(I am on the issue page)
end

Given 'I am at an issue page' do
  @issue = Issue.first
  Given %(I am on the issue page)
end

