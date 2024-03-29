/** @type {import("@babel/core").ConfigFunction} */
module.exports = function(api) {
  api.cache(true)
  return {
    presets: [['babel-preset-expo']],
    plugins: [
      'react-native-reanimated/plugin',
      'nativewind/babel',
      'expo-router/babel',
      [
        require.resolve('babel-plugin-module-resolver'),
        {
          root: '.',
          alias: {
            app: './app',
          },
        },
      ],
    ],
  }
}
