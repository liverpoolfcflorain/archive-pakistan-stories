export type HeritageSite = {
  id: string;
  slug: string;
  register_number: number;
  title: string;
  location: string;
  site_type: string;
  period: string;
  summary: string;
  description: string;
  archaeological_significance: string;
  cultural_significance: string;
  religious_significance: string;
  historical_significance: string;
  map_x: number;
  map_y: number;
  published: boolean;
};

export type ArchiveSection = {
  id: string;
  section_key: string;
  title: string;
  eyebrow: string;
  body: string;
  published: boolean;
};

export type MediaItem = {
  id: string;
  site_id: string | null;
  kind: "image" | "audio" | "video";
  title: string;
  language: string;
  file_path: string;
  alt_text: string;
  credit: string;
  duration_seconds: number | null;
  sort_order: number;
  published: boolean;
  signedUrl?: string;
};
