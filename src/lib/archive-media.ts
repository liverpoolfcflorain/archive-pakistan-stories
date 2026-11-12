import { supabase } from "@/integrations/supabase/client";
import type { MediaItem } from "@/lib/archive.types";

/**
 * Published recordings and films with short-lived file links. Runs in the browser with the
 * public key only: storage policies let visitors open files attached to published records.
 */
export async function getPublishedMedia(): Promise<MediaItem[]> {
  const { data, error } = await supabase
    .from("media_items")
    .select("*")
    .eq("published", true)
    .order("sort_order");
  if (error || !data?.length) {
    if (error) console.error("Unable to load published archive media.", error.message);
    return [];
  }

  const { data: signed, error: signError } = await supabase.storage
    .from("heritage-media")
    .createSignedUrls(
      data.map((item) => item.file_path),
      3600,
    );
  if (signError || !signed) {
    console.error("Unable to sign archive media links.", signError?.message);
    return [];
  }

  const urlByPath = new Map(signed.map((s) => [s.path, s.signedUrl]));
  const items: MediaItem[] = [];
  for (const item of data) {
    const signedUrl = urlByPath.get(item.file_path);
    if (signedUrl) items.push({ ...item, signedUrl });
  }
  return items;
}
