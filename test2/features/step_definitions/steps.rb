# -*- coding: utf-8 -*-
gem 'capybara', '~>2.0'
gem 'capybara-webkit', '~>0.14.1'
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
Capybara.default_driver = :webkit
include Capybara::DSL
前提 /\"(.+)\"を表示/ do |url|
  visit(url)
end
もし /\"(.+)\"を入力/ do |name|
  fill_in('user', :with => name)
end
もし '確認ボタンを押下' do
  click_button('確認')
end
ならば /メッセージ\"(.+)\"が表示される/ do |text|
  find('#msg').should have_content text
end
ならば /スクリーンショットを取得し\"(.+)\"に保存/ do |filename|
  page.save_screenshot "./#{filename}"
end
