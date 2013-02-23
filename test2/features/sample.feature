﻿# language:ja
機能: ユーザー名を入力してAPIから利用の可否を取得し表示する
 シナリオ: ユーザー名を入力して確認を押下しNGであることを確認
  前提 "http://localhost/project/js_test/capybara/webapp/"を表示
  もし "ユーザー名"を入力
  かつ 確認ボタンを押下
  ならば メッセージ"利用できません"が表示される
 シナリオ: 利用可否の確認中メッセージが表示された後利用可のメッセージが表示されること。
  前提 "http://localhost/project/js_test/capybara/webapp/"を表示
  かつ Sinon.JSを利用する
  かつ fakeserverを設定する
  もし "ねこ"を入力
  かつ 確認ボタンを押下
  ならば メッセージ"確認中"が表示される
  もし ユーザー名が利用可の応答を受け取る
  ならば メッセージ"利用可能です"が表示される
 シナリオ: getJSONの引数チェック
  前提 "http://localhost/project/js_test/capybara/webapp/"を表示
  かつ Sinon.JSを利用する
  かつ getJSONにspyを設定する
  もし "いぬ"を入力
  かつ 確認ボタンを押下
  ならば 引数"いぬ"でgetJSON処理を実行する
  かつ getJSON処理が1回実行されている
  もし "ねこ"を入力
  かつ 確認ボタンを押下
  ならば 引数"ねこ"でgetJSON処理を実行する
  かつ getJSON処理が2回実行されている
