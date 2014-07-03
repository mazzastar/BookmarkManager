Feature: Forgotten Password Recovery
In order to allow recovery of a password if forgotten
As A user
	
	Scenario: User has forgotten password
	Given I am on the "/sessions/new" page
	Then I should see "Forgotten Password"

	Scenario: User asks for password
	Given I am on the "sessions/new" page
	When I click on the "Forgotten Password" link
	Then I should see "Please provide your email"
	And I should expect to see the "Recover" submit button


	Scenario: User supplies email
	Given I am on the "/sessions/recover" page
	And there exists a user has login details "test@test.com" and "password"
	When I fill in "email" with "test@test.com"
	And I click "Recover"
	Then I should see "Recovery email sent"