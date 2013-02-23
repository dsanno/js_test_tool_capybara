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
前提 'Sinon.JSを利用する' do
  f = File.open('features/js/sinon.js', "r")
  sinon = f.read;
  page.execute_script sinon
  f.close
end
前提 'fakeserverを設定する' do
  page.execute_script <<-JS
    server = sinon.fakeServer.create();
  JS
end
もし 'ユーザー名が利用可の応答を受け取る' do
  # 最後に受けたRequestに対して応答する
  page.execute_script <<-JS
    var idx = server.requests.length - 1;
    server.requests[idx].respond(200, {"Content-Type": "application/json"}, '{"status":"ok"}');
  JS
end
前提 'getJSONにspyを設定する' do
  page.execute_script <<-JS
    var spy = sinon.spy($, "getJSON");
  JS
end
ならば /引数\"(.+)\"でgetJSON処理を実行する/ do |name|
  js = "spy.calledWith('./status', {'name': \'#{name}\'})"
  ok = page.evaluate_script js
  unless ok
    raise "unexpected param"
  end
end
ならば /getJSON処理が(\d+)回実行されている/ do |expect|
  count = page.evaluate_script <<-JS
    spy.callCount;
  JS
  if count.to_i != expect.to_i
    raise "unexpected callcount #{count} != #{expect}"
  end
end
