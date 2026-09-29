import emblem from "@/assets/archive/emblem.png.asset.json";
import fieldMap from "@/assets/archive/field-map.jpg.asset.json";
import gulshan from "@/assets/archive/gulshan-e-shauda.jpg.asset.json";
import draid from "@/assets/archive/gurdwara-sahib-draid.jpg.asset.json";
import koiyan from "@/assets/archive/upper-koiyan.jpg.asset.json";
import poonch from "@/assets/archive/poonch-fort.jpg.asset.json";
import baral from "@/assets/archive/baral-fort.jpg.asset.json";
import kachayi from "@/assets/archive/kotli-kachayi.jpg.asset.json";
import seri from "@/assets/archive/seri-temple.jpg.asset.json";
import ranbir from "@/assets/archive/ranbir-singh-baradari.jpg.asset.json";
import chatti from "@/assets/archive/chatti-badshahi.jpg.asset.json";

export const archiveAssets = {
  emblem: emblem.url,
  fieldMap: fieldMap.url,
  "gulshan-e-shauda": gulshan.url,
  "gurdwara-sahib-draid": draid.url,
  "upper-koiyan-baoli": koiyan.url,
  "sikh-structures-poonch": gulshan.url,
  "old-poonch": poonch.url,
  "baral-fort": baral.url,
  "kotli-kachayi-fort": kachayi.url,
  "seri-temple": seri.url,
  "ranbir-singh-baradari": ranbir.url,
  "gurdwara-chatti-badshahi": chatti.url,
} as const;
