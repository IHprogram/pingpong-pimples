# アプリケーション名
Ping Pong Pimples

# URL
http://pppimples.com/

※ 1/14までサイトにアクセスできない問題が発生しましたが、無事解決しました。ご迷惑をおかけして申し訳ありませんでした。

# 概要

　卓球のラバーについてレビューをすることができるアプリです。  
  ユーザーがこのアプリでできることは以下の通りです。

- 商品のレビューを投稿できる
- 投稿されたレビューを閲覧できる
- レビューに対していいねやコメントができる
- 他のユーザーをフォローできる

# 使用技術・言語
- フロントエンド(HTML, CSS, Javascript, jQuery)
- バックエンド(Ruby on Rails)
- テスト(RSpec, FactoryBot, Capybara)
- データベース(MySQL)
- 開発環境(MacOS,Visual Studio Code,Git,GitHub)

# 制作背景
　「卓球をしている人々のラバー選びに関する悩み」を解決したいと考えたためです。

　卓球は、どのラバーを使用するかでプレースタイルが大きく変化するスポーツであり、ラバー選びが試合の勝敗を左右すると言っても過言ではありません。そのため「自分のプレースタイルに合うラバーはどれだろうか」という悩みを持つ選手は多くいます。

　そこで、私は「ラバーの性能についてわかるサービスがあれば、ラバー選びに関する悩みが減るのではないか」と考え、このサービスを制作しました。

# 機能一覧

- ログイン機能
- ゲストログイン機能
- レビュー投稿機能
- レビュー検索機能
- レビュー一覧表示機能
- レビュー詳細表示機能
- レビュー編集機能
- レビュー削除機能
- レビューへのいいね機能（非同期通信）
- レビューへのコメント機能（非同期通信）
- 動画投稿機能
- ユーザーフォロー機能（非同期通信）

# DB設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | null: false |
| email                | string  | null: false |
| password             | string  | null: false |
|self_introduction     | text    |             |

### Association

- has_many :reviews
- has_many :likes
- has_many :comments
- has_many :like_reviews, through: :likes, source: :review

## reviews テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| manufacture_id      | integer    | null: false                    |
| type_id             | integer    | null: false                    |
| spin_id             | integer    | null: false                    |
| speed_id            | integer    | null: false                    |
| control_id          | integer    | null: false                    |
| hardness_id         | integer    | null: false                    |
| price               | integer    | null: false                    |
| evaluation_id       | integer    | null: false                    |
| content             | text       | null: false                    |
| likes_count         | integer    | null: false                    |
| comments_count      | integer    | null: false                    |
| video               | string     |                                |
| user                | references | null: false, foreign_key: true |

### Association

- has_many :likes
- has_many :comments
- has_many :users, through: :likes
- belongs_to :user

## likesテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| review              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :review

## commentsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| content             | text       |                                |
| user                | references | null: false, foreign_key: true |
| review              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :review

## relationshipsテーブル

| Column              | Type       | Options                                       |
| ------------------- | ---------- | --------------------------------------------- |
| user                | references | null: false, foreign_key: true                |
| follow              | references | null: false, foreign_key: {to_table: :users}  |

### Association

- belongs_to :user
- belongs_to :follow
