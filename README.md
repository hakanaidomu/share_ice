# [シェアあいす!](https://shareice.net)
# アプリケーション概要
![f3b0bc8ec3c1801d88942c2ec563c8d5](https://user-images.githubusercontent.com/76892391/111876701-46013d80-89e3-11eb-83eb-e70505b55a12.gif)

シェアあいす!は食べたアイスの感想を投稿できるアプリです。  
* アイスの感想の投稿、編集、削除を行うことができます。  
* ユーザー詳細画面において使った金額や摂取カロリーを確認することができます。  
* 投稿に対しては非同期通信を用いてコメントといいねを送ることができます。  
* トップページでは投稿に基づいた画像をスライドショーで実装し、様々な投稿を眺めることができます。  

# 本番環境
http://3.114.221.28/
* 右上かんたんログインボタンよりゲストユーザーとしてログインすることができます。  

# 制作背景
私はアイスが好きです。日々様々なアイスを食べています。  
毎週のように新発売の商品が売り場に並び、アイスを購入する上で、今日はどのアイスを食べよう、どのアイスにするべきかいつも悩んでいました。  
そこで新発売のアイスだったり、お気に入りのアイスを他の人と気軽に共有できたらと思いこのアプリケーションを開発しました。  
また、投稿時に金額やカロリーを入力を行うことができ、金額や摂取カロリーをグラフ化することによって可視化を行いました。  
データを可視化することによって、アイスへの愛を示せるアプリケーションになっております。  

# DEMO  
##  チャート図の導入  

[![Image from Gyazo](https://i.gyazo.com/fb299e42d46e6995221a3ded73a2b49d.jpg)](https://gyazo.com/fb299e42d46e6995221a3ded73a2b49d)

* ユーザー詳細ページでは使った金額と摂取カロリーを棒グラフで確認することができます。  
* また、1週間ごとの金額と摂取カロリー、今までの合計金額と摂取カロリーを表示することができます。

## スライドショー機能の実装
![e0c7a4e08b8c828ad670a130841a743f](https://user-images.githubusercontent.com/76892391/111876776-a5f7e400-89e3-11eb-83aa-ffb1845441b7.gif)
* トップページでは投稿された画像をスライドショーで楽しむことができます。  
* 投稿された画像をランダムに表示させることによって様々な画像を楽しむことができます。  
* スライドショーの画像をクリック時には投稿の詳細ページに遷移いたします。

## タグの絞り込み機能
![945973815866760f317419a5e85587dc](https://user-images.githubusercontent.com/76892391/111877005-95943900-89e4-11eb-9aa1-3c291e6ea42f.gif)
* タグをクリックすることにより、投稿の絞り込みができます。  
* 絞り込んだ投稿のスライドショーを楽しむことができます。

## コメント機能、いいね機能の実装(非同期通信)
![38e53071c3e3e5704c801644bcc61cfa](https://user-images.githubusercontent.com/76892391/111877110-0d626380-89e5-11eb-92a4-c955d345c64b.gif)
* 投稿には非同期通信を用いた、いいねとコメントを送ることができます。  
* いいねの取り消しと、コメント削除も非同期で行うことができます。

## その他の機能  
* bootstrapを用いたレスポンシブデザイン対応。  
* gem kaminariを用いたページネーション機能の実装。  
* gem rails_adminを用いた管理者機能の実装。  
(管理者が容易に削除や編集ができるようにしております)  
* gem acts-as-taggable-onとbootstrap-tagsinputを用いたタグ付機能の実装。  

# 工夫したポイント
## チャート図の実装  
* 投稿に紐づくデータに基づいてチャート図を表示するように実装いたしました。  
* gem 'chartkick'とgem 'groupdate'を用いて実装を行いましたが、日本語の文献が少なく苦労いたしました。  
* 特に直近７日分だけのデータを取得して表示させる方法がわからず、公式リファレンスをみて様々な方法を試して実装を行いました。  
* また、実装方法や苦労した点についてをQiitaに投稿を行いました。  
[【Rails】chartkickとgroupdateを使って投稿に紐づくデータでグラフを作る](https://qiita.com/nicotineweb/items/b765f14bcf9fdd1f1fd8)

## ブラッシュアップ
* 実際にアプリを公開し、利用した方の意見を取り入れブラッシュアップを行いました。  
* ブラッシュアップを行った例は以下の通りです。  
* 公開時には値段の上限値を999になるようにバリデーションを設定していましたが、1000円以上のアイスも登録したいという利用者の意見を受け、値段を1999まで登録できるようにバリデーションを再設定しました。  
* タグ入力画面がわかりづらいと言うご意見を受け、説明文や例文を修正し登録画面をわかりやすくいたしました。   

## テストコード  
* アプリを公開するに当たって、品質担保のためテストコードを100件以上書きました。  
* また、CircleCIを導入し、プルリクエスト作成時に自動でRSpecが実行され、テストを通過しないとマージできない構築を行いました。  

# 使用技術(開発環境)

## バックエンド
* Ruby 2.6.5
* Rails 6.0.3.5

## フロントエンド 
* HTML/CSS 
* JavaScript, jQuery
* Bootstrap 4.5.0

## データベース
* MySQL  

## インフラ  
* AWS(EC2, S3)
* Capistrano

## WEBサーバー(本番環境)
* nginx

## アプリケーションサーバー(本番環境)
* unicorn

## ソース管理
* GitHub, GitHubDesktop

## テスト  
* RSpec

## エディタ
* VScode

# 今後実装したい機能
* ランキング機能の実装  
* UI、UXの改善
* Vue.jsを導入し、一部SPA化

# ER図 
[![Image from Gyazo](https://i.gyazo.com/7eabed6e48685953a5fc537e956743b3.png)](https://gyazo.com/7eabed6e48685953a5fc537e956743b3)
