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
