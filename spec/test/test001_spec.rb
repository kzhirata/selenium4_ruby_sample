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
      result = top.search('selenium')
      expect(page).to have_title('selenium - Google 検索')
      expect(result.search_results[0]).to have_text('Seleniumブラウザー自動化プロジェクト')
    end

  end
end
