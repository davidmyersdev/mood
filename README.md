# mood

Keeping track of emotions over time for better mental health awareness.

## development

Clone the repo to your machine, and run the following commands.

```shell
# build docker containers / start app
docker-compose up -d

# create and migrate database
docker-compose exec web bin/rails db:create db:migrate

# generate credentials (see secrets below)
docker-compose exec web bin/rails g credentials
```

### secrets

#### with `config/credentials.yml.enc`

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

#### with `.env` (used by docker-compose) or env vars

```shell
ALLOWED_ORIGINS=yourdomain.example
APP_URL=https://yourdomain.example
RACK_ENV=development
RAILS_ENV=development
RAILS_TIME_ZONE=Eastern Time (US & Canada)
SECRET_KEY_BASE=arandomstring
SENTRY_CLIENT_DSN=https://yoursentryclientdsn.example
SENTRY_DSN=https://yoursentryserverdsn.example
VAPID_PRIVATE_KEY=yourprivatekey
VAPID_PUBLIC_KEY=yourpublickey
VAPID_SUBJECT=https://yourdomain.example
```

### testing

#### Insomnia REST Client

There is a workspace export file in this repo at `insomnia.json`. To update this file, create a manual export of the workspace with your changes at `insomnia-export.json`, and run the following command.

```bash
cat insomnia-export.json | jq --sort-keys > insomnia.json
```

Insomnia exports are minified by default, and there is no guarantee on key order. This will make the diffs easier to reason about.

## hosting

Do the following to host this app.

### origins

This app uses CORS restriction, so you need to specify which domains are allowed to contact this API.

```shell
# this env var must be available in the rails app
ALLOWED_ORIGINS='app1.example,app2.example'
```

As documented above, you can specify multiple domains with a `,` delimiter.

### secrets

You can generate a new credentials file for production by using the same generator from the development section above. This will generate a `config/master.key` file. If you would prefer to use an environment variable for the master key, you can configure it like this.

```shell
# used to decrypt your credentials file
RAILS_MASTER_KEY=arandomstring
```

#### with env vars

You can forgo the credentials file entirely by using environment variables.

```shell
ALLOWED_ORIGINS=yourdomain.example
APP_URL=https://yourdomain.example
DATABASE_URL=postgres://username:password@yourdatabasehost.example:5432
RACK_ENV=production
RAILS_ENV=production
RAILS_TIME_ZONE=Eastern Time (US & Canada)
SECRET_KEY_BASE=arandomstring
SENTRY_CLIENT_DSN=https://yoursentryclientdsn.example
SENTRY_DSN=https://yoursentryserverdsn.example
VAPID_PRIVATE_KEY=yourprivatekey
VAPID_PUBLIC_KEY=yourpublickey
VAPID_SUBJECT=https://yourdomain.example
```
