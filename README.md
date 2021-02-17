*

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
| image            | string        |                                |
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