Feature: Customer API Integration Tests

  Background:
    Given the API base URL 'http://localhost:8080'

  Scenario: Retrieve a customer by ID successfully
    Given a customer with ID 1 exists
    When I send a GET request to '/customers/1'
    Then the response status should be 200
    And the response should contain the customer details for ID 1

  Scenario: Retrieve a customer by ID when customer does not exist
    Given no customer with ID 999 exists
    When I send a GET request to '/customers/999'
    Then the response status should be 404
    And the response should contain 'Customer not found'

  Scenario: Retrieve a customer by ID with invalid ID format
    When I send a GET request to '/customers/invalid-id'
    Then the response status should be 400
    And the response should contain 'Bad Request'

  Scenario: Retrieve a customer by ID with server error
    Given the server is down
    When I send a GET request to '/customers/1'
    Then the response status should be 500
    And the response should contain 'Internal Server Error'

  Scenario: Create a new customer successfully
    Given a new customer with name 'John Doe' and email 'john.doe@example.com'
    When I send a POST request to '/customers' with the customer details
    Then the response status should be 201
    And the response should contain the created customer details

  Scenario: Create a new customer with missing fields
    Given a new customer with missing email
    When I send a POST request to '/customers' with the incomplete customer details
    Then the response status should be 400
    And the response should contain 'Bad Request'

  Scenario: Create a new customer with server error
    Given the server is down
    When I send a POST request to '/customers' with any customer details
    Then the response status should be 500
    And the response should contain 'Internal Server Error'

  Scenario: Delete a customer successfully
    Given a customer with ID 1 exists
    When I send a DELETE request to '/customers/1'
    Then the response status should be 204
    And the customer should be deleted

  Scenario: Delete a customer that does not exist
    Given no customer with ID 999 exists
    When I send a DELETE request to '/customers/999'
    Then the response status should be 404
    And the response should contain 'Customer not found'

  Scenario: Delete a customer with invalid ID format
    When I send a DELETE request to '/customers/invalid-id'
    Then the response status should be 400
    And the response should contain 'Bad Request'

  Scenario: Delete a customer with server error
    Given the server is down
    When I send a DELETE request to '/customers/1'
    Then the response status should be 500
    And the response should contain 'Internal Server Error'
