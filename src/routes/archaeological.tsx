import { createFileRoute } from "@tanstack/react-router";
import { TopicPage } from "@/components/archive-public";

export const Route = createFileRoute("/archaeological")({
  head: () => ({ meta: [
    { title: "Archaeological Significance — Yemberzal" },
    { name: "description", content: "Study masonry, plans, water systems, building phases and condition notes for the Yemberzal heritage register." },
    { property: "og:title", content: "Archaeological Significance — Yemberzal" },
    { property: "og:description", content: "Masonry, plans, water systems and condition notes from the Yemberzal heritage register." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: () => <TopicPage topic="archaeological" />,
});
