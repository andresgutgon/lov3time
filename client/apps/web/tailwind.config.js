const preset = require('tailwind-config/tailwind.config.js')

/** @type {import('tailwindcss').Config} */
module.exports = {
  presets: [preset],
  content: [
    './src/pages/**/*.{ts,tsx}',
    '../../packages/ui/**/*.{js,jsx,ts,tsx}',
  ],
}
