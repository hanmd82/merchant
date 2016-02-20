Feature: Visit store and to select and buy items

  Users should be able to view the store inventory and browse items.
  Users can click on store items to add to cart and change quantities.
  Users should be able to check out their cart and make payment.

  Scenario: View an item's details
    Given there is an 'Oranges' item in the products list
    When the user goes to the products URL
    Then the user should see "Oranges"
    When the user clicks on the "Oranges" link
    Then the user should see the 'Oranges' item details
    And the user should see the 'Back' link
    When the user clicks on the "Back" link
    And the user should be at the home page

  Scenario: Add an item to cart when not logged in
    Given there is an 'Oranges' item in the products list
    When the user goes to the products URL
    And the user clicks on the "Add to Cart" button for the 'Oranges' item
    Then the user should see "Your Cart"
    And the user should see "Oranges"
    And the 'Oranges' item should have quantity 1
    When the user clicks on the "Continue shopping" link
    Then the user should be at the home page

  Scenario: Check out cart when not logged in
    Given the user has an 'Oranges' item in the cart
    And the user is at the home page
    When the user clicks on the "My Cart" link
    Then the user should see "Your Cart"
    And the user should see "Oranges"
    When the user clicks on the "Checkout Cart" link
    Then the user should see "Please login or sign up to proceed with purchase."

  Scenario: Check out cart when logged in and has shipping address
    Given the user has an 'Oranges' item in the cart
    And the user has a shipping address
    When the user logs in
    Then the user should be at the home page
    And the user should see the user name
    When the user clicks on the "My Cart" link
    Then the user should see "Your Cart"
    When the user clicks on the "Checkout Cart" link
    Then the user should see "Please select a shipping address"
    When the user clicks on the "Proceed" button
    Then the user should see "Order Status: submitted"

  Scenario: Reload user's cart upon login
    Given the user has a pending cart with 3 'Carrots' items
    When the user logs in
    Then the user should be at the home page
    And the user should see the user name
    When the user clicks on the "My Cart" link
    Then the user should see "Carrots"
    And the 'Carrots' item should have quantity 3

  Scenario: Combine pending carts with same items after login
    Given the user has a pending cart with 3 'Oranges' items
    And the user has an 'Oranges' item in the cart
    When the user logs in
    Then the user should be at the home page
    And the user should see the user name
    When the user clicks on the "My Cart" link
    Then the user should see "Oranges"
    And the 'Oranges' item should have quantity 4

  Scenario: Add an item to cart when logged in
  Scenario: Empty cart
