Feature: Visit store to select and buy items

  Users should be able to view the store inventory and browse items.
  Users can click on store items to add to cart and change quantities.
  Users should be able to check out their cart and make payment.

  Scenario: View an item's details
    Given there is a 'Oranges' item in the products list
    When the user goes to the products URL
    Then the user should see the 'Oranges' item in the product catalogue
    When the user clicks on the 'Oranges' link
    Then the user should see the 'Oranges' item details
    And the user should see the 'Back' link
    And the user should be able to go back to the products catalogue page
