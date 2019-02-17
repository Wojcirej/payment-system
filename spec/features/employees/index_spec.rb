require 'rails_remote_helper'

def open_employees_list_page
  open_home_page
  visit_page("Employee's list")
end

def navigate_to_second_page
  page.all('a').to_a.find { |x| x.text == "2" }.trigger(:click)
end

feature "Employee's list page", js: true do

  scenario "Allows to select 5, 10, 25, 50 or 100 items per page" do
    open_employees_list_page
    expect(page).to have_selector("paginator-per-page-selector")
    within("paginator-per-page-selector") do
      expect(page).to have_content("Items per page")
      select_options = page.find('select').all('option').map { |x| x.value.split(": ").last }
      expect(select_options).to match_array(["5", "10", "25", "50", "100"])
    end
  end

  context "when items to display on the list available" do

    scenario "Displays pages navigation links" do
      open_employees_list_page
      expect(page).to have_selector("paginator-pages-selector")
      within("paginator-pages-selector") do
        pages_links = page.all('a')
        expect(pages_links.count).to be > 0
      end
    end

    scenario "Displays first page by default" do
      open_employees_list_page
      within("paginator-pages-selector") do
        active_page_button = page.find('a.active')
        expect(active_page_button.text).to eq("1")
      end
    end

    scenario "Does not display button navigating to previous page by default" do
      open_employees_list_page
      within("paginator-pages-selector") do
        visible_buttons_labels = page.all('a').map { |button| button.text }
        expect(visible_buttons_labels).not_to include("«")
      end
    end

    context "when more than one page available" do

      scenario "Displays button allowing to navigate to the next page" do
        open_employees_list_page
        within("paginator-pages-selector") do
          next_page_button = page.all('a').last
          expect(next_page_button.text).to eq("»")
        end
      end

      scenario "Can navigate to the other pages" do
        open_employees_list_page
        within("paginator-pages-selector") do
          navigate_to_second_page
          active_page_button = page.find('a.active')
          expect(active_page_button.text).to eq("2")
        end
      end

      scenario "After navigating off the first page, button navigating to previous page is displayed" do
        open_employees_list_page
        within("paginator-pages-selector") do
          navigate_to_second_page
          previous_page_button = page.all('a').first
          expect(previous_page_button.text).to eq("«")
        end
      end
    end
  end
end
