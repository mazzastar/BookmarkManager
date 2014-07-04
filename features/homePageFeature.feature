Feature: Bookmarks are saved
In order to access favourite pages quickly
As a user

Background:
Given I have a registered user 
When I am logged in

	Scenario: View home page
	Given I am on the homepage 
	Then I should see "Bookmark Manager"

	Scenario: Add link
	Given I am on the homepage
	When I click link "Add Link" 
	And I fill in "title" with "title_test"
	And I fill in "url" with "http://www.makersacademy.com"
	And I click "add"
	Then I should see "title_test" in a link

	Scenario: With a couple of Tags
	Given I am on the homepage
	When I click link "Add Link" 
	And I fill in "title" with "title_test"
	And I fill in "url" with "http://www.makersacademy.com"
	And I fill in the "tags" with "codeschool learning_course"
	And I click "add"
	Then I should see "codeschool"
	And I should see "learning_course"