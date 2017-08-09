require 'rails_helper'

RSpec.feature "Visitor adds something to their cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They see the cart items change" do
    # ACT
    visit root_path
    first('article.product').first('a.btn.btn-primary').click

    expect(page).to have_css("ul.nav.navbar-nav.navbar-right", text: " My Cart (1)")

    # save_screenshot
  end
end