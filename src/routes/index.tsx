import { createFileRoute } from "@tanstack/react-router";
import { ArchiveHome } from "@/components/archive-public";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "Yemberzal — The Forgotten Sikh History in Kashmir" },
      { name: "description", content: "A living archive of Rawalakot and Poonch heritage with photographs, a field map, oral recordings and tours." },
      { property: "og:title", content: "Yemberzal — The Forgotten Sikh History in Kashmir" },
      { property: "og:description", content: "A living archive of Rawalakot and Poonch heritage with photographs, a field map and oral recordings." },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: ArchiveHome,
});
