Given(/^I am on the "(.*?)" page$/) do |page|

   visit("#{page}")

end

Then(/^the first user email should be "(.*?)"$/) do |email|
  expect(User.first.email).to eq email
  # pending # express the regexp above with the code you wish you had
end