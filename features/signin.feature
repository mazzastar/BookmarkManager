Feature: Users can sign in
In order to log into their account
As a user
	
	Scenario: When logged out and with correct credentials
	Given I am on the "/sessions/new" page and there exists a user has login details "test@test.com" and "password"
	When I fill in "email" with "test@test.com"
	And I fill in "password" with "password"
	And I click "Sign In"
	Then I should see "Welcome, test@test.com"

	Scenario: When logged out with incorrect correct credentials
	Given I am on the "/sessions/new" page and there exists a user has login details "test@test.com" and "password"
	When I fill in "email" with "test@test.com"
	And I fill in "password" with "password2"
	And I click "Sign In"
	Then I should see "Unknown user-password combination"

	
	Scenario: When logged out with incorrect correct credentials and attempting to enter in a link
	Given I am on the homepage
	When I click link "Add Link" 
	And I fill in "title" with "title_test"
	And I fill in "url" with "http://www.makersacademy.com"
	And I click "add"
	Then I should see "Not logged in"

 
