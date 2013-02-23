# language:ja
機能: ユーザー名を入力してAPIから利用の可否を取得し表示する
 シナリオ: ユーザー名を入力して確認を押下しNGであることを確認
  前提 "http://localhost/project/js_test/capybara/webapp/"を表示
  もし "ユーザー名"を入力
  かつ 確認ボタンを押下
  ならば メッセージ"利用できません"が表示される
