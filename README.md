# シェアあいす!
# アプリケーション概要
[![Image from Gyazo](https://i.gyazo.com/42eba0f920aa4710594e50822b5cfcae.gif)](https://gyazo.com/42eba0f920aa4710594e50822b5cfcae)

シェアあいす!は食べたアイスの感想を投稿できるアプリです。  
・アイスの感想の投稿、編集、削除を行うことができます。  
・ユーザー詳細画面において使った金額や摂取カロリーを確認することができます。  
・投稿に対しては非同期通信を用いてコメントといいねを送ることができます。  
・トップページでは投稿に基づいた画像をスライドショーで実装し、様々な投稿を眺めることができます。  

# 本番環境
https://shareice.net  
右上かんたんログインボタンよりゲストユーザーとしてログインすることができます。  

# 制作背景
私はアイスが好きです。日々様々なアイスを食べています。  
アイスは毎週のように新発売の商品が売り場に並び、  
アイスを購入する上で、今日はどのアイスを食べよう、どのアイスにするべきかいつも悩んでいました。  
そこで新発売のアイスだったり、お気に入りのアイスを他の人と気軽に共有できたらと思いこのアプリケーションを開発しました。  
また、投稿時に金額やカロリーを入力を行う、金額や摂取カロリーをグラフ化することによって可視化を行いました。  
こうすることによって、アイスへの愛を示せるアプリケーションになっております。  

# DEMO  
## スライドショー機能の実装
[![Image from Gyazo](https://i.gyazo.com/b3d58d9db6ec06de1f277bd81f469b48.gif)](https://gyazo.com/b3d58d9db6ec06de1f277bd81f469b48)
・トップページでは投稿された画像をスライドショーで楽しむことができます。  
・投稿された画像をランダムに表示させることによって様々な画像を楽しむことができます。  
・スライドショーの画像をクリック時には投稿の詳細ページに遷移いたします。

***
## タグの絞り込み機能
[![Image from Gyazo](https://i.gyazo.com/ad3801382588cb9452b5116954c48b9f.gif)](https://gyazo.com/ad3801382588cb9452b5116954c48b9f)
・タグをクリックすることにより、投稿の絞り込みができます。  
・絞り込んだ投稿のスライドショーを楽しむことができます。

***

[![Image from Gyazo](https://i.gyazo.com/1ebef693d8750d497507d4c1395a405d.gif)](https://gyazo.com/1ebef693d8750d497507d4c1395a405d)
・投稿には非同期通信を用いたいいねとコメントを送ることができます。  
・いいねの取り消しと削除も非同期で行うことができます。

***
##  チャート図の導入  

[![Image from Gyazo](https://i.gyazo.com/fb299e42d46e6995221a3ded73a2b49d.jpg)](https://gyazo.com/fb299e42d46e6995221a3ded73a2b49d)

ユーザー詳細ページでは使った金額と摂取カロリーを棒グラフで確認することができます。

## その他の機能  
・


# テーブル設計

## usersテーブル

| Column             | Type   | options                  |
|--------------------| -------|------------------------- |
| nickname           | string | null: false              |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false              |
| admin              | boolean| null: false              |
 
### Association
- has_many :share_ice
- has_many :comments
- has_many :likes
- has_one  :profile

## share_iceテーブル

| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| title            | string        | null: false                    |
| text             | text          | null: false                    |
| image            | string        | null: false                    |
| price            | integer       |                                |
| calorie          | integer       |                                |
| user_id          | references    | null: false, foreign_key: true |
| profile_id       | references    | null: false, foreign_key: true |
| likes_count      | integer       |                                |
 
### Association
- belongs_to :user
- belomgs_to :profile
- has_many   :comments
- has_many   :likes
- has_many   :share_ice_tags

## commentsテーブル

| Column         | Type          | options                        |
| ---------------| ------------- | ------------------------------ |
| comment        | text          | null: false                   |  
| user_id        | references    | null: false, foreign_key: true |
| share_ice_id   | references    | null: false, foreign_key: true |

### Association
- belong_to :user
- has_one   :share_ice

## likesテーブル

| Column            | Type          | options                        |
| ----------------- | ------------- | ------------------------------ |
| comment           | text          | null: false                    |
| user_id           | references    | null: false, foreign_key: true |
| share_ice_id      | references    | null: false, foreign_key: true |

### Association
- belong_to :user
- has_one   :share_ice

## user_profileテーブル
| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| profile          | text          |                                |
| peofile_image    | string        |                                |
| total_price      | integer       |                                |
| total_caloerie   | integer       |                                |
| user_id          | integer       | null: false, foreign_key: true |

### Association
-belong_to :user
-has_many  :share_ices

## share_ice_tagsテーブル
| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| tag_name         | text          |                                |
| share_ice_tag    | text          |                                |

### Association
-belongs_to :share_ice
-belongs_to :tags

## tagsテーブル
| Column           | Type          | options                        |
| ---------------- | ------------- | ------------------------------ |
| tag_name         | text          | null: false                    |
| share_ice_tag    | text          |                                |

### Association
-has_many :share_ice_tags