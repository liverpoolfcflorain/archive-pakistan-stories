import { createFileRoute } from "@tanstack/react-router";
import { RecordingsPage } from "@/components/archive-public";

export const Route = createFileRoute("/recordings")({
  head: () => ({ meta: [
    { title: "Recordings and Films — Yemberzal" },
    { name: "description", content: "Listen to oral-history recordings and watch multilingual films for the Yemberzal heritage archive." },
    { property: "og:title", content: "Recordings and Films — Yemberzal" },
    { property: "og:description", content: "Oral-history recordings and multilingual films for the Yemberzal heritage archive." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: RecordingsPage,
});
