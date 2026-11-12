// Archive photographs and the opening film ship inside the site (public/), so any host serves them.
const img = (file: string) => `/images/${file}`;

export const archiveAssets = {
  emblem: img("emblem.png"),
  fieldMap: img("field-map.jpg"),
  homeFilm: "/media/yemberzal-home-film.mp4",
  "gulshan-e-shauda": img("gulshan-e-shauda.jpg"),
  "gurdwara-sahib-draid": img("gurdwara-sahib-draid.jpg"),
  "upper-koiyan-baoli": img("upper-koiyan.jpg"),
  "sikh-structures-poonch": img("gulshan-e-shauda.jpg"),
  "old-poonch": img("poonch-fort.jpg"),
  "baral-fort": img("baral-fort.jpg"),
  "kotli-kachayi-fort": img("kotli-kachayi.jpg"),
  "seri-temple": img("seri-temple.jpg"),
  "ranbir-singh-baradari": img("ranbir-singh-baradari.jpg"),
  "gurdwara-chatti-badshahi": img("chatti-badshahi.jpg"),
} as const;
