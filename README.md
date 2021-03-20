# シェアあいす!
# アプリケーション概要
[![Image from Gyazo](https://i.gyazo.com/42eba0f920aa4710594e50822b5cfcae.gif)](https://gyazo.com/42eba0f920aa4710594e50822b5cfcae)

シェアあいす!は食べたアイスの感想を投稿できるアプリです。  
* アイスの感想の投稿、編集、削除を行うことができます。  
* ユーザー詳細画面において使った金額や摂取カロリーを確認することができます。  
* 投稿に対しては非同期通信を用いてコメントといいねを送ることができます。  
* トップページでは投稿に基づいた画像をスライドショーで実装し、様々な投稿を眺めることができます。  

# 本番環境
https://shareice.net  
* 右上かんたんログインボタンよりゲストユーザーとしてログインすることができます。  

# 制作背景
私はアイスが好きです。日々様々なアイスを食べています。  
毎週のように新発売の商品が売り場に並び、アイスを購入する上で、今日はどのアイスを食べよう、どのアイスにするべきかいつも悩んでいました。  
そこで新発売のアイスだったり、お気に入りのアイスを他の人と気軽に共有できたらと思いこのアプリケーションを開発しました。  
また、投稿時に金額やカロリーを入力を行う、金額や摂取カロリーをグラフ化することによって可視化を行いました。  
データを可視化することによって、アイスへの愛を示せるアプリケーションになっております。  

# DEMO  
## スライドショー機能の実装
[![Image from Gyazo](https://i.gyazo.com/b3d58d9db6ec06de1f277bd81f469b48.gif)](https://gyazo.com/b3d58d9db6ec06de1f277bd81f469b48)
* トップページでは投稿された画像をスライドショーで楽しむことができます。  
* 投稿された画像をランダムに表示させることによって様々な画像を楽しむことができます。  
* スライドショーの画像をクリック時には投稿の詳細ページに遷移いたします。

***
## タグの絞り込み機能
[![Image from Gyazo](https://i.gyazo.com/ad3801382588cb9452b5116954c48b9f.gif)](https://gyazo.com/ad3801382588cb9452b5116954c48b9f)
* タグをクリックすることにより、投稿の絞り込みができます。  
* 絞り込んだ投稿のスライドショーを楽しむことができます。

***
## コメント機能、いいね機能の実装(非同期通信)
[![Image from Gyazo](https://i.gyazo.com/1ebef693d8750d497507d4c1395a405d.gif)](https://gyazo.com/1ebef693d8750d497507d4c1395a405d)
* 投稿には非同期通信を用いた、いいねとコメントを送ることができます。  
* いいねの取り消しと削除も非同期で行うことができます。

***
##  チャート図の導入  

[![Image from Gyazo](https://i.gyazo.com/fb299e42d46e6995221a3ded73a2b49d.jpg)](https://gyazo.com/fb299e42d46e6995221a3ded73a2b49d)

* ユーザー詳細ページでは使った金額と摂取カロリーを棒グラフで確認することができます。  
* また、1週間ごとの金額と摂取カロリー、今までの合計金額と摂取カロリーを表示することができます。

## その他の機能  
* bootstrapを用いたレスポンシブデザイン対応。  
* gem kaminariを用いたページネーション機能の実装。  
* gem rails_adminを用いた管理者機能の実装。  
(管理者が容易に削除や編集ができるようにしております)  
* gem acts-as-taggable-onとbootstrap-tagsinputを用いてタグ付機能の実装。  

# 工夫したポイント
## チャート図の実装  
* 投稿に紐づくデータに基づいてチャート図を表示するように実装いたしました。  
* gem "chartkick"とgem 'groupdate'を用いて実装を行いましたが、日本語の文献が少なく苦労いたしました。  
* 特に直近７日分だけのデータを取得して表示させる方法がわからず、公式リファレンスをみて様々な方法を試して実装を行いました。  
* また、実装方法や苦労した点についてをQiitaに投稿を行いました。  
[【Rails】chartkickとgroupdateを使って投稿に紐づくデータでグラフを作る](https://qiita.com/nicotineweb/items/b765f14bcf9fdd1f1fd8)
***

## ブラッシュアップ
* 実際にアプリを公開し、利用した方の意見を取り入れブラッシュアップを行いました。  
* ブラッシュアップを行った例は以下の通りです。  
* 例を書く    
* 例を書く  
* 例を書く  
***

## テストコード  
* アプリを公開するに当たって、品質担保のためテストコードを100件以上書きました。  
* また、CircleCIを導入し、プルリクエスト作成時に自動でRSpecが実行され、テストを通過しないとマージできない設定にしてあります。  

# 使用技術(開発環境)

## バックエンド
* Ruby 2.6.5
* Rails 6.0.5

## フロントエンド 
* HTML/CSS 
* JavaScript,jQuery
* bootstpar 4.5.0

## データベース
* MySQL  

## インフラ  
* AWS(EC2, S3, Route53, ACM, ALB)
* Capistrano

## WEBサーバー(本番環境)
* nginx

## アプリケーショーんサーバー(本番環境)
* unicorn

## ソース管理
* GitHub,  GitHubDesktop

## テスト  
* RSpec

## エディタ
* VScode

***

# テーブル設計

## usersテーブル

| Column             | Type   | options                  |
|--------------------| -------|------------------------- |
| nickname           | string | null: false              |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false              |
| description        | text   |                          |
| peofile_image      | string |                          |
 
### Association
- has_many :posts
- has_many :comments
- has_many :likes

## postsテーブル

| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| content          | text          | null: false                    |
| image            | string        | null: false                    |
| price            | integer       |                                |
| calorie          | integer       |                                |
| user_id          | references    | null: false, foreign_key: true |
| likes_count      | integer       |                                |
 
### Association
- belongs_to :user
- has_many   :comments
- has_many   :likes
- has_many   :post_tags

## commentsテーブル

| Column         | Type          | options                        |
| ---------------| ------------- | ------------------------------ |
| content        | text          | null: false                    |  
| user_id        | references    | null: false, foreign_key: true |
| post_id        | references    | null: false, foreign_key: true |

### Association
- belong_to :user
- has_one   :post

## likesテーブル

| Column            | Type          | options                        |
| ----------------- | ------------- | ------------------------------ |
| user_id           | references    | null: false, foreign_key: true |
| posts_id          | references    | null: false, foreign_key: true |

### Association
- belong_to :user
- has_one   :post

## post_tagsテーブル
| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| tag_name         | text          |                                |
| post_tag         | text          |                                |

### Association
- belongs_to :post
- belongs_to :tags

## tagsテーブル
| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| tag_name         | text          | null: false                    |
| post_tag         | text          |                                |

### Association
- has_many :post_tags


# ER図 
[![Image from Gyazo](https://i.gyazo.com/295df8004f2e7bd9129305d0c7b82bae.png)](https://gyazo.com/295df8004f2e7bd9129305d0c7b82bae)