# アプリケーション名
Ping Pong Pimples

# 概要

　卓球の表ソフトラバー・粒高ラバーについてレビューをすることができるアプリです。  
  ユーザーがこのアプリでできることは以下の通りです。
- 商品（表ソフトラバー・粒高ラバー）のレビューを投稿できる
- 投稿されたレビューを閲覧できる
- レビューに対していいねやコメントをできる

# 使用技術・言語
- フロントエンド(HTML, CSS, Javascript)
- バックエンド(Ruby on Rails)
- テスト(RSpec, FactoryBot, Capybara)
- データベース(MySQL)
- 開発環境(MacOS,Visual Studio Code,Git,GitHub)

# 制作背景

  「卓球をしている人々の表ソフトラバー、粒高ラバー選びに関する悩み」を解決したいと考えたためです。  
　まず、卓球のラバーの種類は、大きく「裏ソフトラバー、表ソフトラバー、粒高ラバー」という3つに分けられます。  
　現在の卓球界は裏ソフトラバーの使用する選手が主流となっており、表ソフトラバーや粒高ラバーの使用者は裏ソフトラバー使用者に比べると少ない傾向にあります。そのため、既存のラバーレビューサイトも、裏ソフトラバーのレビューが多く投稿されています。  
　対して、表ソフトラバーや粒高ラバーのレビューは、裏ソフトラバーに比べると少ないです。そのため、表ソフトラバーや粒高ラバーを使用する選手は、「自分が気になる商品のレビューがなく、購入するべきか迷う」といった悩みを抱えています。用具に詳しい指導者が身近にいれば相談できますが、そのような指導者がどの環境にもいるとは限りません。その結果、多くの選手は「実際に使用しないと、ラバーの性能がわからない」という状況下で、自分に合ったラバーを探さなくてはなりません。  
　私自身も表ソフトラバーや粒高ラバーを購入して使用したとき、「せっかく3000円も出して買ったラバーが、イメージしていた性能と全然違った」という苦い経験を味わったことがあります。 そして、「裏ソフトラバーなら参考になるレビューが多くて、ラバーの特徴が事前に分かるのにな」と常々思っていました。  
以上のような経緯から「表ソフトラバーと粒高ラバーに特化したレビューアプリがあれば、それらのラバー選びに悩む人が減るのではないか」と考え、今回のアプリを作ろうと考えました。

# DEMO
今後追加予定

# 実装予定の内容

- ログイン機能
- レビュー投稿機能
- ユーザーのプロフィール編集機能
- レビュー検索機能
- レビュー一覧表示機能
- レビュー詳細表示機能
- レビュー編集機能
- レビュー削除機能
- レビューへのいいね機能
- コメント機能
- 動画投稿機能

# DB設計

## users テーブル

| Column               | Type    | Options     |
| -------------------- | ------- | ----------- |
| nickname             | string  | null: false |
| email                | string  | null: false |
| password             | string  | null: false |

### Association

- has_many :reviews
- has_many :likes
- has_one :profile

## reviews テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| manufacturer_id     | integer    | null: false                    |
| type_id             | integer    | null: false                    |
| hardness            | integer    | null: false                    |
| spin_id             | integer    | null: false                    |
| speed_id            | integer    | null: false                    |
| price               | integer    | null: false                    |
| level_id            | integer    | null: false                    |
| evaluation_id       | integer    | null: false                    |
| content             | text       | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- has_many :likes
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

## profilesテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| grade               | text       |                                |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
