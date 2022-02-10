# サービス概要
「TwiLinks」は、Twitterで見つけた気になる記事を後で見たい場合にURLを保存するのが手間、という問題を解決したいブックマーク管理サービスです。

ユーザーは「いいね」したツイートに含まれるURLの一覧化ができ、
Pocketとは違って、記事にアクセスすることなくTwitterで「いいね」するだけでURLが保存できる事が特徴です。

## 環境

- Ruby 3.1.0
- Rails 7.0.2
- PostgreSQL 13.0

# セットアップ

```
$ ./bin/setup
$ rails server
```

# ローカルで動かす場合

ローカルの動作環境には PostgreSQL が必要です。

また、TwitterのAPIを使用しているのでAPI Keyなどの環境変数の設定が必要です。別途Twitter API Key等を取得し、環境変数にセットしてください。

## 環境変数のセット

- TWITTER_API_KEY = Twitter API Key
- TWITTER_API_SECRET = Twitter API Secret

# テスト

```
$ ./bin/test
```

# Lint

```
$ ./bin/lint
```
