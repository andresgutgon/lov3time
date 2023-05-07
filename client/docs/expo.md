# Expo + Expo Router Example

Use [`expo-router`](https://expo.github.io/router) to build native navigation using files in the `app/` directory.

## Expo included packages.

Expo SDK comes with some packages prebuild. Like `react-native-reanimated`. This
is great. The downside is that you want to use a newer version of that packages
you have to do a pre-build of your app. For that you have to have a ready dev
machine with Android Studio or XCode setup and do this:

Let's say I want to use `v3` of `react-native-reanimated`

```
pnpm i react-native-reanimated@3
```

Then run

```
pnpm expo run:ios
```

## EAS

EAS Build is a hosted service for building app binaries for your Expo and React Native projects.
More [info here](https://docs.expo.dev/build/introduction/)
Install the CLI:
```
 pnpm i -g eas-cli
```

## Clean cache of a build
When you need a newer version of an npm package that has native dependencies you
maybe need stop using `pnpm expo start --ios` and do `pnpm expot run:ios`
The difference is that the second option is using a prebuild version of your app
and its dependencies by running:
```
pnpm expo prebuild --platform ios --clear
```
Use `--clear` when you want to make sure you don't have an old cached version.
This fixed for me the error of adding `babel-plugin-module-resolver` and not
seeing working paths as I wanted to be defined.
So this Babel plugin help us to use `app/something` instead of relative paths
like `import something from '../../something'` which is fucking annoying and I
am a spoiled dev that want things in some specific way.


This will create an `ios` folder in `client/apps/mobile/ios`
This is the build of the app with `v3` of `react-native-reanimated`. Once next Expo
SDK comes with `v3` included all we have to is remove `ios` folder.

## 📝 Notes

- [Expo Router: Docs](https://expo.github.io/router)
- [Expo Router: Repo](https://github.com/expo/router)
- [Request for Comments](https://github.com/expo/router/discussions/1)
