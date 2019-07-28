### Userモデル

|id |name  |email  |password|password_confirmation|
|---|---|---|---|---|
|bigint|string|string|string|

### Taskモデル

|id |user_id  |work  |hose_work|private|
|---|---|---|---|---|
|bigint|int|text|text|text|

### TaskToLabelモデル

|id |task_id  |lavel_id  |
|---|---|---|
|bigint|int|int|

### Labelモデル

|id |red  |yellow  |green|
|---|---|---|---|
|bigint|text|text|text|

### herokuデプロイの為の手順

まずcommitを行う
```
$ git add .
$ git commit -m "コッミトメッセージ"
```

Heroku上にアプリケーションを作成する
```
$ heroku create
```

Herokuにデプロイする
```
$ git push heroku master
```

Herokuデータベースの作成は自動で行われるが、マイグレーションは手動で実行する
```
$ heroku run rails db:migrate
```

作成したアプリを開く
```
$ heroku open
```