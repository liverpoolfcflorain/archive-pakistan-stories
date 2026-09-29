import { createFileRoute } from "@tanstack/react-router";
import { TopicPage } from "@/components/archive-public";

export const Route = createFileRoute("/cultural")({
  head: () => ({ meta: [
    { title: "Cultural Significance — Yemberzal" },
    { name: "description", content: "Read how Pahari memory, place-names and oral traditions keep the monuments of Rawalakot legible." },
    { property: "og:title", content: "Cultural Significance — Yemberzal" },
    { property: "og:description", content: "Pahari memory, place-names and oral traditions around the Rawalakot monuments." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: () => <TopicPage topic="cultural" />,
});
