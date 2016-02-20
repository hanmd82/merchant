## Merchant 
#### About
The [Merchant Rails project](https://merchant-rails-app.herokuapp.com) is an online grocery shop based on [Jumpstart Lab Merchant tutorial](http://tutorials.jumpstartlab.com/projects/merchant.html). Users can:
- Specify new product details and add to product listing
- View products list and add the products that they want to purchase to their cart
- Edit the item quantites in their cart
- Delete items from cart or empty cart
- Checkout their cart, add shipping address and confirm order
- Login using their Twitter account


#### Additional Components
Here are the additional components that were not part of the tutorial:
- Using PostgreSQL database in *development* and *test* environments
- Version source control using Git and GitHub
- Deployment to Heroku [here](https://merchant-rails-app.herokuapp.com)
- Generating Twitter API key & secret key (instead of using the keys given in the tutorial) and setting the environment variables in local and Heroku
- Unit Testing (TDD) using Rspec
- Integration Testing (BDD) using Cucumber, Capybara, Rspec
- Database seeding

[This project is built on Ruby v2.2.2, Rails v4.2.2]

#### Refinements

There were some bugs and issues with the business workflow (e.g. product stock does not decrease with purchase) after the tutorial was completed. Below are the added refinements that were completed after the tutorial. For the summarised list of issues/bugs and solutions during the coding process, refer to the wiki page [here](https://github.com/thenglee/merchant/wiki/Post-tutorial:-Issues-and-solutions).

##### Product
* Dynamic product stock update with user order process:
  * Product stock decreases when user
    * Adds product item to cart
    * Increases the item quantity in the cart
  * Product stock increases when user
    * Decrease the cart item quantity
    * Delete the cart item
    * Empty the cart

##### Order
* Replace 'Shipping To' section and 'Submit' button with 'Checkout Cart' link
* Updated checkout cart process:

  When user clicks on 'Checkout Cart' link, if user is
  * Not logged in: Display link to login page
  * Logged in: Show 'Shipping Address' section. If user
    * Has no shipping address, display 'Add new shipping address' link
    * Has shipping address, display address selection dropdown and 'Proceed' button. When user clicks on the 'Proceed' button, display order number and updated order status.
* Redirect to 'Confirmed Order' page when user views a submitted order (to prevent user from editing or re-submitting the order)

##### Login
* Load user's pending order (if any) upon user login
* If user has an order currently in session and then proceed to log in, combine the session order items with user's pending order (if any)

##### Sidebar
* Display 'My Cart' link in top sidebar
