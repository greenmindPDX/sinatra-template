Feature: Orders inquiry service
  Scenario: Fetching all orders
    Given the orders:
    | Total_Cost |
    | 19.99 |
    | 86753.09 |
    And I send and accept JSON
    When I send a GET request for "/orders"
    Then the response should be "200"
    And the JSON response should be an array with 2 "order" elements
