Given(/^I am on the "(.*?)" page$/) do |page|

   visit("#{page}")

end

Then(/^the first user email should be "(.*?)"$/) do |email|
  expect(User.first.email).to eq email
end

Then(/^the user count should be (\d+)$/) do |arg1|
  expect(User.count).to eq 0
end