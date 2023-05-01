# What's this?

This is the client part of the application. It has 2 clients. A web client done
with NextJS and a mobile client done with React Navite + Expo.

The project is done with Turbo repo. You can react documentaion specific for
turbo repo in [the documentaion](./docs/turbo.md)

## Mobile app

Specific [documentaion](./docs/expo.md)

To start running the IOS simulator do:

```
cd ./client/apps/mobile
pnpm dev:ios
```

Run with `--clear` to start with a fresh Metro bundler cleaning cache.

To start running the Android simulator do:

```
cd ./client/apps/mobile
pnpm dev:android
```

### Choose between iPhone versions

Once the bundler for expo (Metro) finish compiling the dev version do `shift+i`
to choose which version of iPhone you want to use.

## Web app

With this command you can start NextJS app + UI package

```
turbo dev --filter={web,ui}
```
