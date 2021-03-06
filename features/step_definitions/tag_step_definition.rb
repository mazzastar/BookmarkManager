Given(/^I have four links and two have the same tag:$/) do |links_info|
  # table is a Cucumber::Ast::Table
  user = User.create(:email => "text2@text2.com", :password => "password", :password_confirmation => "password")
	link_hashes = links_info.hashes
   	link_hashes.each do |link_info|
		tags = link_info[:tags].split(" ").map{|tag_string| Tag.first_or_create(:tagname => tag_string)}
    link = Link.create(:title => link_info[:title], :url => link_info[:url], :tags => tags, :user => user)
   end
  visit('/')
end

When(/^I press the "(.*?)" tag$/) do |search_tag|
	first(:link, search_tag).click	
end

Then(/^I should only see "(.*?)" and "(.*?)" with the associated links with the tag and not "(.*?)" or "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  page.should have_link arg1
  page.should have_link arg2
  page.should have_no_content arg3
  page.should have_no_content arg4
end
