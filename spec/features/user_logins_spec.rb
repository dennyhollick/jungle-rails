require 'rails_helper'

RSpec.feature "Visitor signs in", type: :feature, js: true do

  # SETUP
  before :each do
    @good_user = User.create({
      first_name: 'George',
      last_name: 'Vargess',
      email: 'george@nothing.com',
      password: '123456789',
      password_confirmation: '123456789'
    })
  end

  scenario "They are able to login and see the root" do
    # ACT
    visit "/login"

    #save_screenshot

    within 'form' do
      fill_in id: 'email', with: @good_user.email
      fill_in id: 'password', with: @good_user.password

      click_button 'Submit'
    end

    expect(page).to have_current_path(root_path, only_path: true)
    expect(page).to have_css("ul.nav.navbar-nav.navbar-right", text: "Hi #{@good_user.first_name}!")

  end
end