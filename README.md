# mood

Keeping track of emotions over time for better mental health awareness.

## development

Clone the repo to your machine, and run the following commands.

```shell
# build docker containers / start app
docker-compose up -d

# create and migrate database
docker-compose exec web bin/rails db:create db:migrate

# generate credentials (read more below)
docker-compose exec web bin/rails g credentials
```

### credentials

The last command above will generate `config/master.key` and `config/credentials.yml.enc`. The credentials file is encrypted, but you can view the contents with a rails command.

```shell
# dump the decrypted contents of config/credentials.yml.enc to the terminal
docker-compose exec web bin/rails credentials:show
```

The output should look similar to this.

```yaml
secret_key_base: arandomstring
vapid_private_key: yourprivatekey
vapid_public_key: yourpublickey
vapid_subject: https://yourdomain.example
```

These secrets are all necessary to run the app. The `secret_key_base` is used by Rails, but the VAPID keys are necessary to send web push notifications. This process will generate a new set of VAPID keys for you. For more information about VAPID, [check out the spec](https://tools.ietf.org/html/rfc8292).

## hosting

Do the following to host this app.

### origins

This app uses CORS restriction, so you need to specify which domains are allowed to contact this API.

```shell
# this env var must be available in the rails app
ALLOWED_ORIGINS='app1.example,app2.example'
```

As documented above, you can specify multiple domains with a `,` delimiter.

### credentials

You should generate a new credentials file for production. You can use the same generator from the development section above. If you would prefer to use an environment variable instead of the generated `config/master.key`, you can configure it like this.

```shell
# used to decrypt your credentials file
RAILS_MASTER_KEY='arandomstring'
```
