import { createFileRoute } from "@tanstack/react-router";
import { FieldMapPage } from "@/components/archive-public";

export const Route = createFileRoute("/field-map")({
  head: () => ({ meta: [
    { title: "Heritage Sites — Yemberzal" },
    { name: "description", content: "Explore the register of ten Sikh and Dogra-era heritage sites across Rawalakot and Poonch." },
    { property: "og:title", content: "Heritage Sites — Yemberzal" },
    { property: "og:description", content: "Explore the register of ten heritage sites across Rawalakot and Poonch." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: FieldMapPage,
});
