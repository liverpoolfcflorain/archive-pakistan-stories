import { createFileRoute } from "@tanstack/react-router";
import { TourPage } from "@/components/archive-public";

export const Route = createFileRoute("/book-a-tour")({
  head: () => ({ meta: [
    { title: "Book a Tour — Yemberzal" },
    { name: "description", content: "Contact the Yemberzal archive to plan a heritage visit to Rawalakot and the Poonch region." },
    { property: "og:title", content: "Book a Tour — Yemberzal" },
    { property: "og:description", content: "Plan a heritage visit to Rawalakot and the Poonch region." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary_large_image" },
  ] }),
  component: TourPage,
});
