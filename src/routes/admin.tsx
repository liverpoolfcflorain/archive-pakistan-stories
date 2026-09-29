import { createFileRoute } from "@tanstack/react-router";
import { AdminPage } from "@/components/admin-page";

export const Route = createFileRoute("/admin")({
  ssr: false,
  head: () => ({ meta: [
    { title: "Archive Editor — Yemberzal" },
    { name: "description", content: "Private editor access for the Yemberzal field archive." },
    { property: "og:title", content: "Archive Editor — Yemberzal" },
    { property: "og:description", content: "Private editor access for the Yemberzal field archive." },
    { property: "og:type", content: "website" },
    { name: "twitter:card", content: "summary" },
    { name: "robots", content: "noindex" },
  ] }),
  component: AdminPage,
});