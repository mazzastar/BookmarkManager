Feature: Users can sign in
In order to log into their account
As a user
	
	Scenario: When Logged Out
	Given I am on the "/sessions/new" page and there exists a user has login details "test@test.com" and "password"
	When I fill in "email" with "test@test.com"
	And I fill in "password" with "password"
	And I click "Sign In"
	Then I should see "Welcome, test@test.com"

	Scenario: When Logged Out
	Given I am on the "/sessions/new" page and there exists a user has login details "test@test.com" and "password"
	When I fill in "email" with "test@test.com"
	And I fill in "password" with "password2"
	And I click "Sign In"
	Then I should see "Unknown user-password combination"
 