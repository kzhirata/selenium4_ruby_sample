# frozen_string_literal: true

class SearchResultPage < SitePrism::Page
  set_url '/search'
  elements :search_results   , 'h3'
end
