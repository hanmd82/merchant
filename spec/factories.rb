FactoryGirl.define do
  factory :product_oranges, class: Product do
    title        "Oranges"
    description  "Bag of 6 Valencia oranges"
    image_url    "oranges.jpg"
    price        2.99
    stock        50
  end

  factory :product_carrots, class: Product do
    title        "Carrots (1 pack)"
    description  "A pack of 5 carrots"
    image_url    "carrots.jpg"
    price        3.20
    stock        30
  end
end
