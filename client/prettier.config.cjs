/** @typedef  {import("@ianvs/prettier-plugin-sort-imports").PluginConfig} SortImportsConfig*/
/** @typedef  {import("prettier").Config} PrettierConfig*/
/** @typedef  {{ tailwindConfig: string }} TailwindConfig*/

/** @type { PrettierConfig | SortImportsConfig | TailwindConfig } */
const config = {
  arrowParens: 'always',
  printWidth: 80,
  singleQuote: true,
  jsxSingleQuote: true,
  semi: false,
  trailingComma: 'all',
  tabWidth: 2,
  // pluginSearchDirs: false,
  // FIXME: Plugins DON'T work
  /* plugins: [ */
  /*   '@ianvs/prettier-plugin-sort-imports', */
  /*   'prettier-plugin-tailwindcss', */
  /* ], */
  /* tailwindConfig: './packages/ui/ds/tailwind/theme', */
  /* importOrder: [ */
  /*   '^(react/(.*)$)|^(react$)|^(react-native(.*)$)', */
  /*   '^(next/(.*)$)|^(next$)', */
  /*   '^(expo(.*)$)|^(expo$)', */
  /*   '<THIRD_PARTY_MODULES>', */
  /*   '', */
  /*   '^ui/(.*)$', */
  /*   '', */
  /*   '^~/utils/(.*)$', */
  /*   '^~/components/(.*)$', */
  /*   '^~/styles/(.*)$', */
  /*   '^~/(.*)$', */
  /*   '^[./]', */
  /* ], */
  /* importOrderSeparation: false, */
  /* importOrderSortSpecifiers: true, */
  /* importOrderBuiltinModulesToTop: true, */
  /* importOrderParserPlugins: ['typescript', 'jsx', 'decorators-legacy'], */
  /* importOrderMergeDuplicateImports: true, */
  /* importOrderCombineTypeAndValueImports: true, */
}

module.exports = config
