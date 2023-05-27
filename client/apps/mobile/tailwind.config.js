// eslint-disable-next-line @typescript-eslint/no-var-requires
const preset = require('tailwind-config/tailwind.config.js')

/** @type {import('tailwindcss').Config} */
module.exports = {
  presets: [preset],
  content: [
    './src/pages/**/*.{ts,tsx}',
    '../../packages/ui/**/*.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        inter400: ['Inter_400'],
        inter500: ['Inter_500'],
        inter700: ['Inter_700'],
        inter900: ['Inter_900'],
      },
    },
  },
}
