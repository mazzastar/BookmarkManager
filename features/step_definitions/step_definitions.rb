Given(/^I have a registered user$/) do
  user = User.create(:email => "text@text.com", :password => "password", :password_confirmation => "password")
  sign_in("text@text.com", "password")
end

When(/^I click on "(.*?)"$/) do |arg1|
  find_button(arg1).click 
end

When(/^I click link "(.*?)"$/) do |arg1|
	click_link('Add Link')
end


When(/^I am logged in$/) do
	sign_in("text@text.com", "password")
end

Given(/^I am on the homepage$/) do
  visit '/'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content arg1
end


When(/^I fill in "(.*?)" with "(.*?)"$/) do |name, value|
  fill_in name, with: value
end

When(/^I click "(.*?)"$/) do |button|
  find_button(button).click
end

Then(/^I should see "(.*?)" in a link$/) do |elem|
  page.should have_link(elem)
end

When(/^I fill in the "(.*?)" with "(.*?)"$/) do |tags, tagString|
	fill_in tags, with: tagString
end

Then(/^I should not see "(.*?)"$/) do |arg1|
  page.should_not have_content arg1
end

# When(/^I fill in the "(.*?)" with \["(.*?)", "(.*?)"\]$/) do |tags, tag1, tag2|
#   fill_in 'tags', :with => tags.join(' ')
# end