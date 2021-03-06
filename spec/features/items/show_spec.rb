require 'rails_helper'

RSpec.describe 'item show page', type: :feature do

  before(:each) do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @review_1 = @chain.reviews.create!(title: "Best Item Ever", content: "I mean it. This item is the best thing ever!", rating: 5)
    @review_2 = @chain.reviews.create!(title: "Waste Of Money", content: "What a total waste of money. This item broke on the first use.", rating: 1)

    visit "/items/#{@chain.id}"
  end

  it 'shows item info' do
    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")
  end

  it 'shows a list of reviews for that item' do
    within "#review-#{@review_1.id}" do
      expect(page).to have_content("Best Item Ever")
      expect(page).to have_content("I mean it. This item is the best thing ever!")
      expect(page).to have_content(5)
    end

    within "#review-#{@review_2.id}" do
      expect(page).to have_content("Waste Of Money")
      expect(page).to have_content("What a total waste of money. This item broke on the first use.")
      expect(page).to have_content(1)
    end
  end

  it "have an area for stats about reviews" do
    review_3 = @chain.reviews.create!(title: "Durable", content: "Really strong chain.", rating: 5)
    review_4 = @chain.reviews.create!(title: "Great!", content: "Easy to use. Works on my bike.", rating: 4)
    review_5 = @chain.reviews.create!(title: "Worst!", content: "This item is the worst.", rating: 1)
    review_6 = @chain.reviews.create!(title: "Meh", content: "Okay item but not the best item.", rating: 2)
    review_7 = @chain.reviews.create!(title: "Mid review", content: "Okay.", rating: 3)

    visit "/items/#{@chain.id}"

    within "#stats-#{@chain.id}" do
      expect(page).to have_content("Top Reviews: #{@review_1.title} #{@review_1.rating}")
      expect(page).to have_content("Top Reviews: #{review_3.title} #{review_3.rating}")
      expect(page).to have_content("Top Reviews: #{review_4.title} #{review_4.rating}")
      expect(page).to have_content("Bottom Reviews: #{@review_2.title} #{@review_2.rating}")
      expect(page).to have_content("Bottom Reviews: #{review_5.title} #{review_5.rating}")
      expect(page).to have_content("Bottom Reviews: #{review_6.title} #{review_6.rating}")
      expect(page).to have_content("Average Review: 3")
    end
  end

    it "see's an edit button for review" do

      expect(page).to have_link "Edit Review"
    end
end
