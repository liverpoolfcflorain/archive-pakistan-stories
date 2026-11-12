import { createServerFn } from "@tanstack/react-start";
import type { MediaItem } from "@/lib/archive.types";

export const getPublishedMedia = createServerFn({ method: "GET" }).handler(async () => {
  const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
  const { data, error } = await supabaseAdmin
    .from("media_items")
    .select("*")
    .eq("published", true)
    .order("sort_order");

  if (error || !data) {
    console.error("Unable to load published archive media.");
    return [];
  }

  const signedItems = await Promise.all(
    data.map(async (item) => {
      const { data: signed, error: signingError } = await supabaseAdmin.storage
        .from("heritage-media")
        .createSignedUrl(item.file_path, 3600);

      if (signingError || !signed?.signedUrl) return null;
      return { ...item, signedUrl: signed.signedUrl };
    }),
  );

  return signedItems.filter(
    (item): item is MediaItem & { signedUrl: string } => item !== null,
  );
});