 def sign_in(email, password)
    visit '/sessions/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign In'
 end


Given(/^I am on the "(.*?)" page and I am logged in$/) do |home|
  user = User.create(:email => "text@text.com", :password => "password", :password_confirmation => "password")
  sign_in("text@text.com", "password")
end