When(/^I click on the "(.*?)" link$/) do |link|
  click_link(link)
end

Then(/^I should expect to see the "(.*?)" submit button$/) do |name|
   page.should have_button(name)
end

Given(/^there exists a user has login details "(.*?)" and "(.*?)"$/) do |email, password|
  user = User.create(:email => email, :password => password, :password_confirmation => password)
end