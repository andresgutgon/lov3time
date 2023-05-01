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

This will create an `ios` folder in `client/apps/mobile/ios`
This is the build of the app with `v3` of `react-native-reanimated`. Once next Expo
SDK comes with `v3` included all we have to is remove `ios` folder.

## 📝 Notes

- [Expo Router: Docs](https://expo.github.io/router)
- [Expo Router: Repo](https://github.com/expo/router)
- [Request for Comments](https://github.com/expo/router/discussions/1)
