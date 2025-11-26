Feature: Message Retrieval

  Scenario: Retrieve the default message
    Given the application is running
    When I request the default message
    Then I should receive "hello      World!"
