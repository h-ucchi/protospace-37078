# README

# テーブル設計

## users テーブル

| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| email              | string | null: false, unique_key: true |
| encrypted_password | string | null: false                   |
| name               | string | null: false                   |
| profile            | text   | null: false                   |
| occupation         | text   | null: false                   |
| position           | text   | null: false                   |

### Association

- has_many :prototype
- has_many :comments, through: :prototype

## prototype テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| catch_copy         | text       | null: false                    |
| concept            | text       | null: false                    |
| user               | references | null: false, foreign_key: true |



### Association

- belongs_to :users
- has_many :comments, through: :users

## comments テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| content            | text       | null: false                    |
| prototype          | reference  | null: false, foreign_key: true |
| user               | reference  | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :prototype
