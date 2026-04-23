import pluginVue from "eslint-plugin-vue";

export default [
  ...pluginVue.configs["flat/recommended"],
  {
    rules: {
      "no-console": "warn",
      "no-unused-vars": "error",
      "vue/no-unused-vars": "error",
      "vue/no-unused-components": "error",
      "vue/multi-word-component-names": "off",
      "vue/no-reserved-component-names": "off",
      "vue/require-default-prop": "off",
      "vue/require-explicit-emits": "warn",
      "vue/max-attributes-per-line": "off",
    },
  },
  {
    ignores: ["dist/", "node_modules/"],
  },
];
