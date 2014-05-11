Given(/^I am on the "(.*?)" page$/) do |page|

   visit("#{page}")

end

Then(/^the first user email should be "(.*?)"$/) do |email|
  expect(User.first.email).to eq email
end

Then(/^the user count should be (\d+)$/) do |arg1|
  expect(User.count).to eq arg1.to_i
end

Then(/^Current Path should be "(.*?)"$/) do |arg1|
  expect(current_path).to eq('/users')
end

When(/^there is already a user with my intended name$/) do
  user = User.create(:email => "alex@me.com",  :password => "password2", :password_confirmation => "password2")
end

