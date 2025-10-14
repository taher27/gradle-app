Feature: Customer API Integration Tests

  Scenario: Retrieve all customers successfully
    Given the API base URL 'http://localhost:8080'
    When I send a GET request to '/customers'
    Then the response status should be 200
    And the response should contain a list of customers

  Scenario: Retrieve a customer by ID successfully
    Given the API base URL 'http://localhost:8080'
    And a customer with ID 1 exists
    When I send a GET request to '/customers/1'
    Then the response status should be 200
    And the response should contain the customer details with ID 1

  Scenario: Attempt to retrieve a non-existent customer by ID
    Given the API base URL 'http://localhost:8080'
    And no customer with ID 999 exists
    When I send a GET request to '/customers/999'
    Then the response status should be 404
    And the response should contain an error message 'Customer not found'

  Scenario: Create a new customer successfully
    Given the API base URL 'http://localhost:8080'
    And the request payload is
      """
      {
        "name": "John Doe",
        "email": "john.doe@example.com"
      }
      """
    When I send a POST request to '/customers' with the request payload
    Then the response status should be 201
    And the response should contain the created customer details

  Scenario: Attempt to create a customer with invalid data
    Given the API base URL 'http://localhost:8080'
    And the request payload is
      """
      {
        "name": "",
        "email": "invalid-email"
      }
      """
    When I send a POST request to '/customers' with the request payload
    Then the response status should be 400
    And the response should contain an error message 'Invalid customer data'

  Scenario: Delete a customer successfully
    Given the API base URL 'http://localhost:8080'
    And a customer with ID 2 exists
    When I send a DELETE request to '/customers/2'
    Then the response status should be 204
    And the customer with ID 2 should no longer exist

  Scenario: Attempt to delete a non-existent customer
    Given the API base URL 'http://localhost:8080'
    And no customer with ID 999 exists
    When I send a DELETE request to '/customers/999'
    Then the response status should be 404
    And the response should contain an error message 'Customer not found'
