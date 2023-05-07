// eslint-disable-next-line @typescript-eslint/no-var-requires
const defaultTheme = require('tailwindcss/defaultTheme')
// eslint-disable-next-line @typescript-eslint/no-var-requires
const preset = require('tailwind-config/tailwind.config.js')

/** @type {import('tailwindcss').Config} */
module.exports = {
  presets: [preset],
  content: [
    './src/app/**/*.{ts,tsx}',
    './src/pages/**/*.{ts,tsx}',
    '../../packages/ui/**/*.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['var(--font-inter)', ...defaultTheme.fontFamily.sans],
      },
    },
  },
}
