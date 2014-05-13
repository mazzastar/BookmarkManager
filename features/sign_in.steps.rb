Given(/^I am on the "(.*?)" page and there exists a user has login details "(.*?)" and "(.*?)"$/) do |signupPage, email, password|
  user = User.create(:email => email, :password => password, :password_confirmation => password)
  visit("#{signupPage}")
end
