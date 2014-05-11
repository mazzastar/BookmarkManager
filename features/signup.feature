Feature: Users can sign up
In order to allow people to be registered on the site
As a user

	Scenario: When Logged Out
	Given I am on the "/users/new" page
	When I fill in "email" with "alex@me.com"
	And I fill in "password" with "password"
	And I fill in "password_confirmation" with "password"	
	And I click "Sign Up"
	Then the first user email should be "alex@me.com"
	And I should see "Welcome, alex@me.com"

	Scenario: Can't sign up when passwords are mismatched
	Given I am on the "/users/new" page
	When I fill in "email" with "alex@me.com"
	And I fill in "password" with "password"
	And I fill in "password_confirmation" with "not_password"	
	And I click "Sign Up"
	Then the user count should be 0
	And Current Path should be "/users"
	And I should see "Password does not match the confirmation"

	Scenario: Can't create a new user if the email exists
	Given I am on the "/users/new" page
	When there is already a user with my intended name
	And I fill in "email" with "alex@me.com"
	And I fill in "password" with "password"
	And I fill in "password_confirmation" with "not_password"	
	And I click "Sign Up"
	Then the user count should be 1 
	And I should see "This email is already taken"