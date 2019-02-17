require 'rails_remote_helper'

feature "Index page", js: true do

  scenario "Menu is available on index page" do
    open_home_page
    within('top-navigation-bar') do
      expect(page).to have_link('Index')
      expect(page).to have_link("Employee's list")
    end
  end
end
