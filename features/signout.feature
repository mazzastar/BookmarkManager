Feature: Users can sign out
In order to allow people to log out of their current session
As a user

	Scenario: User is logged in
	Given I am on the "/" page and I am logged in
	When I click "Sign Out"
	Then I should see "Good bye!"



