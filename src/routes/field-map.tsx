import { createFileRoute } from "@tanstack/react-router";
import { FieldMapPage } from "@/components/archive-public";

export const Route = createFileRoute("/field-map")({
  head: () => ({ meta: [
    { title: "Field Map — Yemberzal" },
    { name: "description", content: "Explore the interactive field map of ten Sikh and Dogra-era heritage sites across Rawalakot and Poonch." },
    { property: "og:title", content: "Field Map — Yemberzal" },
    { property: "og:description", content: "Explore the interactive field map of ten heritage sites across Rawalakot and Poonch." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: FieldMapPage,
});
