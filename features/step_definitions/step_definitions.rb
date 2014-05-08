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