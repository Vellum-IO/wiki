import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  srcDir: "docs",

  title: "Vellum IO Wiki",
  description: "Vellum IO standards and documentation",
  base: "/keeper-wiki/",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    search: {
      provider: "local",
    },
    nav: [{ text: "Home", link: "/" }],

    sidebar: [
      {
        text: "Getting Started",
        items: [{ text: "Welcome", link: "/index" }],
      },
      {
        text: "Keeper",
        items: [
          { text: "Introduction", link: "/keeper/introduction" },
          { text: "Architecture", link: "/keeper/architecture" },
          { text: "Repositories", link: "/keeper/repositories" },
        ],
      },
      {
        text: "Research",
        items: [
          { text: "Message Queues", link: "/reasearch/message-queue.md" },
          { text: "Storage", link: "/k8s/storage" },
        ],
      },
    ],

    socialLinks: [
      { icon: "github", link: "https://github.com/vellum-io/wiki" },
    ],
  },
});
