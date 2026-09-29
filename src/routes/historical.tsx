import { createFileRoute } from "@tanstack/react-router";
import { TopicPage } from "@/components/archive-public";

export const Route = createFileRoute("/historical")({
  head: () => ({ meta: [
    { title: "Historical Significance — Yemberzal" },
    { name: "description", content: "Follow the Yemberzal register from Poonch rulers through Sikh and Dogra periods, Partition and rediscovery." },
    { property: "og:title", content: "Historical Significance — Yemberzal" },
    { property: "og:description", content: "From Poonch rulers through Sikh and Dogra periods, Partition and rediscovery." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: () => <TopicPage topic="historical" />,
});
