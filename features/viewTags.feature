Feature: We can view links associated by Tags
In order to see what I associated by topic
As a user

	Scenario: Filtering links by tags
	Given I have four links and two have the same tag:
	|title 			  |url							|tags                  	|
	|makers			  |http://www.makersacademy.com |education				|
	|google			  |http://www.google.com		|search					|
	|bing			  |http://www.bing.com			|search					|
	|code			  |http://www.code.org			|education				|
	When I press the "search" tag
	Then I should only see "google" and "bing" with the associated links with the tag and not "code" or "makers"