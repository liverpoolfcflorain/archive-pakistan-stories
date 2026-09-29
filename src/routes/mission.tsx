import { createFileRoute } from "@tanstack/react-router";
import { TopicPage } from "@/components/archive-public";

export const Route = createFileRoute("/mission")({
  head: () => ({ meta: [
    { title: "Mission Statement — Yemberzal" },
    { name: "description", content: "Yemberzal’s mission to preserve a public multilingual record of Sikh, Dogra and shared heritage." },
    { property: "og:title", content: "Mission Statement — Yemberzal" },
    { property: "og:description", content: "A public multilingual record of Sikh, Dogra and shared heritage." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: () => <TopicPage topic="mission" />,
});
