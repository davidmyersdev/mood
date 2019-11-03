# mood

Keeping track of emotions over time for better mental health awareness.

## development

Clone the repo to your machine. Run the following commands from the root of the `mood` directory.

```shell
# build docker images / drop, create, and migrate database
./script/setup

# run app and database containers in background
./script/start
```

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

You will need to generate a new credentials file and ensure it has the following structure.

```yaml
secret_key_base: arandomstring
vapid_private_key: yourprivatekey
vapid_public_key: yourpublickey
vapid_subject: https://yourdomain.example
```

Prior to deploy/build, ensure your app has the following environment variable available.

```shell
# required to decrypt your credentials file
RAILS_MASTER_KEY='arandomstring'
```
