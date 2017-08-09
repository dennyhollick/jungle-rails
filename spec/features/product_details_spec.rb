require 'rails_helper'

RSpec.feature "Visitor navigates to a product page", type: :feature, js: true do

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

  scenario "They see the details of the product" do
    # ACT
    visit root_path
    first('a.btn.btn-default.pull-right').click

    expect(page).to have_css 'article.product-detail'

    # save_screenshot
  end
end