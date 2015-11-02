require "rack_session_access/capybara"

Given(/^there is an 'Oranges' item in the products list$/) do
  Product.create(title: "Oranges", price: 2.99, description: "Bag of 6 Valencia oranges", image_url: "oranges.jpg", stock: 50)
end

When(/^the user goes to the products URL$/) do
  visit products_path
end

When(/^the user clicks on the "(.*?)" link$/) do |link_name|
  click_link link_name
end

Then(/^the user should see the 'Oranges' item details$/) do
  expect(page).to have_content('Title: Oranges')
  expect(page).to have_content('Price: $2.99')
  expect(page).to have_content('Description: Bag of 6 Valencia oranges')
  expect(page).to have_content('Stock: 50 In Stock')
end

Then(/^the user should see the 'Back' link$/) do
  find_link('Back').visible?
end

When(/^the user should be able to go back to the home page$/) do
  expect(current_path).to eq root_path
end

When(/^the user clicks on the 'Add to Cart' button for the 'Oranges' item$/) do
  click_button 'Add to Cart'
end

Then(/^the 'Oranges' item should have quantity (\d+)$/) do |item_quantity|
  expect(page).to have_content(item_quantity)
end

Given(/^the user has an 'Oranges' item in the cart$/) do
  product = Product.create(title: "Oranges", price: 2.99, description: "Bag of 6 Valencia oranges", image_url: "oranges.jpg", stock: 50)
  order = Order.create(status: "unsubmitted")
  order.order_items.create(product_id: product.id, quantity: 1)

  page.set_rack_session(order_id: order.id)
end

And(/^the user is at the home page$/) do
  visit root_path
end

Then(/^the user should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

And(/^the user has a shipping address$/) do
  user = User.create(provider: "twitter", uid: "0123456789", name: "User Name")
  address = user.addresses.create(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345")
end

When(/^the user logs in$/) do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '0123456789',
      :info => { :name => 'User Name' }
    })
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

  visit('/auth/twitter/callback')
end

Then(/^the user should be at the home page$/) do
  expect(current_path).to eq root_path
end

Then(/^the user should see the user name$/) do
  expect(page).to have_content('Welcome, User Name')
end

When(/^the user clicks on the 'Proceed' button$/) do
  click_button 'Proceed'
end
