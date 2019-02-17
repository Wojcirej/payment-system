module GeneralRemoteHelpers

  def open_home_page
    visit("/")
  end

  def visit_page(link)
    within('top-navigation-bar') do
      click_link(link)
    end
  end
end
