# アプリケーション名  
study-room

# アプリケーション概要
勉強においてわからない課題や問題があった際に気軽にインターネットにて質問ができ、それに返答ができる

# URL
https://study-room.onrender.com

# テスト用アカウント
メールアドレス taro@toro  
パスワード taro0000

# 利用方法

## 質問投稿
1.ヘッダーあるルーム作成にて質問ルームを作成する  
2.作成した質問ルームに遷移してフォームから質問を行う

## 返答投稿
1.返答したい質問ルームに遷移する  
2.フォームから返答する

## アプリケーションを作成した背景
自宅自習を行なっていてわからない問題に直面した場合に学習が止まってしまうという話があり、わからない問題などをすぐ聞けるような場所がないという課題が発生した。また他の人と勉強についてのコミュニケーションをとることで学習意欲も上がるのではないかと仮説した。気軽にすぐに聞けてまた質問に返答することにより学習の理解を深めると思い質問機能と返答があるアプリケーションを開発することにしました。

## 洗い出した要件
[要件を定義したシート](https://docs.google.com/spreadsheets/d/1hJo9j_d0lpTIHPFuwc5KEJ-2UVJdE59SnVdofUAguDc/edit#gid=982722306)

# 実装した機能についてお画像やGIFおよびその説明
## ・新規登録機能
[![Image from Gyazo](https://i.gyazo.com/a828851bb44f5d12ec16910a5ad6028b.gif)](https://gyazo.com/a828851bb44f5d12ec16910a5ad6028b)

## ・ログイン機能
[![Image from Gyazo](https://i.gyazo.com/2592ebec2b007e9dc7f43d4d876b4d69.gif)](https://gyazo.com/2592ebec2b007e9dc7f43d4d876b4d69)

## ・ユーザー編集機能
[![Image from Gyazo](https://i.gyazo.com/d79de9ed8836525302bc9010bf5a5eab.gif)](https://gyazo.com/d79de9ed8836525302bc9010bf5a5eab)

## ・ログアウト機能
[![Image from Gyazo](https://i.gyazo.com/0cec891747cfe5f215db63b15b8603d6.gif)](https://gyazo.com/0cec891747cfe5f215db63b15b8603d6)

## ルーム作成機能
[![Image from Gyazo](https://i.gyazo.com/e8f5e3467720069adefbf35237cfa746.gif)](https://gyazo.com/e8f5e3467720069adefbf35237cfa746)

## ルーム削除機能
[![Image from Gyazo](https://i.gyazo.com/ce214ba44beedc85795f25523569128d.gif)](https://gyazo.com/ce214ba44beedc85795f25523569128d)

## メッセージ投稿機能
[![Image from Gyazo](https://i.gyazo.com/4804ddb4cb6e642f8196736f4cc891c1.gif)](https://gyazo.com/4804ddb4cb6e642f8196736f4cc891c1)



# データベース設計
[![Image from Gyazo](https://i.gyazo.com/9e323d920ad4ec9aa9f9ffd5e64cd5f9.png)](https://gyazo.com/9e323d920ad4ec9aa9f9ffd5e64cd5f9)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/b46a88988ee803ac8de314c4873dce50.png)](https://gyazo.com/b46a88988ee803ac8de314c4873dce50)

# Userモデル単体テストコード
[![Image from Gyazo](https://i.gyazo.com/dc5f0d8153af1665007b845e4cc7876c.png)](https://gyazo.com/dc5f0d8153af1665007b845e4cc7876c)

# Roomモデル単体テストコード
[![Image from Gyazo](https://i.gyazo.com/bbe741899e15f82c775a062815299519.png)](https://gyazo.com/bbe741899e15f82c775a062815299519)

# Messageモデル単体テストコード
[![Image from Gyazo](https://i.gyazo.com/327051a4e95665aff5aa1dd14a075913.png)](https://gyazo.com/327051a4e95665aff5aa1dd14a075913)

# tagモデル単体テストコード
[![Image from Gyazo](https://i.gyazo.com/4c603782413c2f199f4c2cdbe9b5e4f0.png)](https://gyazo.com/4c603782413c2f199f4c2cdbe9b5e4f0)

# ユーザーの結合コード
[![Image from Gyazo](https://i.gyazo.com/60a86caf1ce73ef49e80cd375c9ffaf6.png)](https://gyazo.com/60a86caf1ce73ef49e80cd375c9ffaf6)

# ルームの結合コード
[![Image from Gyazo](https://i.gyazo.com/284a6c7f57812521d9aaac3b780ca0ef.png)](https://gyazo.com/284a6c7f57812521d9aaac3b780ca0ef)

# メッセージの結合コード
[![Image from Gyazo](https://i.gyazo.com/41bc48fb047166c5f0b41455bfde1ac5.png)](https://gyazo.com/41bc48fb047166c5f0b41455bfde1ac5)

# 実装予定の機能
現在タイトル、学年、タグ検索を実装中。
今後はビューをもう少し見やすくするためのビュー変更を実装予定。

# テーブル設計

## usersテーブル

| Column             | type     | option                   |
| ------------------ | -------- | ------------------------ |
| email              | string   | null: false unique: true |
| encrypted_password | string   | null: false              |
| name               | string   | null: false              |
| school_year_id     | integer  | null: false              |

- has_many :rooms
- has_many :messages

## roomsテーブル

| Column     | type          | option                        |
| ---------- | ------------- | ----------------------------- |
| room       | string        | null: false                   |
| user       | references    | null: false foreign_key: true |


- belongs_to :user
- has_many :messages
- has_many :room_tags
- has_many :tags, through :room_tags


## room_tagsテーブル

| Column             | type       | option                        |
| ------------------ | ---------- | ----------------------------- |
| room               | references | null: false,foreign_key: true |
| tag                | references | null: false,foreign_key: true |

- belongs_to :room
- belongs_to :tag

## tagsテーブル

| Column        | type          | option                         |
| ------------- | ------------- | ------------------------------ |
| name          | string        | null: false                    |

- has_many :room_tags
- has_many :rooms, through :room_tags

## messagesテーブル

| Column        | type          | option                         |
| ------------- | ------------- | ------------------------------ |
| content       | string        | null: false                    |
| user          | references    | null: false, foreign_key: true |
| room          | references    | null: false, foreign_key: true |

- belongs_to :room
- belongs_to :user


# 開発環境
Ruby, Ruby on Rails, HTML, CSS, MySQL

# ローカルでの動作方法
以下のコマンドを入力
% git clone https://github.com/umeduck/study-room.git
% cd study-room
% bundle install
% yarn install

# 工夫したポイント
タグをつけることによりどのようなことに関連するかを可視化できるようにしました。tagsテーブルに同じタグが存在していた場合には新しく保存をすることはなく同じタグが存在しない場合のみtagsテーブル内に新しく保存されるようにしました。  
またトップページではルーム一覧とそれに連なるユーザー情報を取り出すためN+1問題が発生するためincludesメソッドにて解決を行いました。