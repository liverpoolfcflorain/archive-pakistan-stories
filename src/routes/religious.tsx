import { createFileRoute } from "@tanstack/react-router";
import { TopicPage } from "@/components/archive-public";

export const Route = createFileRoute("/religious")({
  head: () => ({ meta: [
    { title: "Religious Significance — Yemberzal" },
    { name: "description", content: "Explore gurdwaras, temples and memorial structures preserved in the sacred geography of Kashmir." },
    { property: "og:title", content: "Religious Significance — Yemberzal" },
    { property: "og:description", content: "Gurdwaras, temples and memorial structures in the sacred geography of Kashmir." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: () => <TopicPage topic="religious" />,
});
