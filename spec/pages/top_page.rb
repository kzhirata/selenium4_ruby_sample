# frozen_string_literal: true

class TopPage < SitePrism::Page
  set_url '/'

  element  :search_form    , 'input[name="q"]'
  elements :submit_buttons , 'input[name="btnK"]'

  def search(word)
    search_form.set(word)
    submit_buttons[0].click
    SearchResultPage.new
  end
end
