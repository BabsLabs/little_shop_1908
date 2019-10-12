require 'rails_helper'

describe "Cart indicator in nav bar" do
  it "can see cart indicator and count on every page" do

    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    visit '/items'

    expect(page).to have_content("Cart: 0")

    visit '/merchants'

    expect(page).to have_content("Cart: 0")

    visit "/merchants/#{@chain.id}"

    expect(page).to have_content("Cart: 0")

  end
end


# describe "When a user adds an items to their cart" do
#   it "displays total number of items in cart" do
#
#     @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
#     @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
#
#     visit "/items"
#
#     expect(page).to have_content("Cart: 0")
#
#     within("#chain-#{@chain.id}") do
#       click_button("Add Item")
#     end
#
#     expect(page).to have_content("Cart: 1")
#
#     within("#song-#{song_2.id}") do
#       click_button("Add Song")
#     end
#
#     expect(page).to have_content("Cart: 2")
#
#     within("#song-#{song_1.id}") do
#       click_button("Add Song")
#     end
#
#     expect(page).to have_content("Cart: 3")
#
#     end
# end