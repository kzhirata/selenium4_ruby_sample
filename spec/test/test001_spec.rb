# -*- coding: utf-8 -*-
# frozen_string_literal: true

require "spec_helper"

describe '検索', type: :feature, js: true do

  before() do
  end

  describe 'seleniumで検索する' do

    it 'タイトルがseleniumであること' do
      top = TopPage.new
      top.load
      result = top.search('selenium.dev')
      if ENV['GITHUB_ACTIONS'] == 'true' 
        expect(page).to have_title('selenium.dev - Google Search')
      else 
        expect(page).to have_title('selenium.dev - Google 検索')
      end
      expect(result.search_results[0]).to have_text('Selenium')
    end

  end
end
