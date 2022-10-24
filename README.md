# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## テーブル設計 ###

# usersテーブル

| Column             | type     | option                   |
| ------------------ | -------- | ------------------------ |
| email              | string   | null: false unique: true |
| encrypted_password | string   | null: false              |
| name               | string   | null: false              |
| school_year_id     | integer  | null: false              |

- has_many :rooms
- has_many :messages

# roomsテーブル

| Column     | type          | option                        |
| ---------- | ------------- | ----------------------------- |
| room       | string        | null: false                   |
| user       | references    | null: false foreign_key: true |


- belongs_to :user
- has_many :messages
- has_many :room_tags
- has_many :tags, through :room_tags


# room_tagsテーブル

| Column             | type       | option                        |
| ------------------ | ---------- | ----------------------------- |
| room               | references | null: false,foreign_key: true |
| tag                | references | null: false,foreign_key: true |

- belongs_to :room
- belongs_to :tag

# tagsテーブル

| Column        | type          | option                         |
| ------------- | ------------- | ------------------------------ |
| name          | string        | null: false                    |

- has_many :room_tags
- has_many :rooms, through :room_tags

# messagesテーブル

| Column        | type          | option                         |
| ------------- | ------------- | ------------------------------ |
| content       | string        | null: false                    |
| user          | references    | null: false, foreign_key: true |
| room          | references    | null: false, foreign_key: true |

- belongs_to :room
- belongs_to :user
