import { Link } from "@tanstack/react-router";
import { Menu, X } from "lucide-react";
import { useState, type ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { archiveAssets } from "@/lib/archive-assets";

const tabs = [
  ["Concept note", "/"],
  ["Field map", "/field-map"],
  ["Archaeological", "/archaeological"],
  ["Cultural", "/cultural"],
  ["Religious", "/religious"],
  ["Historical", "/historical"],
  ["Mission", "/mission"],
  ["Recordings", "/recordings"],
  ["Book a tour", "/book-a-tour"],
] as const;

export function ArchiveShell({ children }: { children: ReactNode }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="min-h-screen bg-parchment text-ink selection:bg-saffron/30">
      <div className="flex min-h-9 items-center justify-between border-b border-ink/10 px-5 py-2 text-[10px] uppercase text-ink/55">
        <span>Rawalakot · Poonch · Azad Kashmir</span>
        <span className="hidden items-center gap-4 sm:flex"><span>پہاڑی</span><span className="text-saffron">Crowd-funded historiography</span></span>
      </div>
      <header className="sticky top-0 z-40 mx-3 mt-3 rounded-2xl border border-card/80 bg-card/75 shadow-archive backdrop-blur-xl md:mx-4">
        <div className="flex items-center justify-between gap-4 px-4 py-3">
          <Link to="/" className="flex shrink-0 items-center gap-3" onClick={() => setOpen(false)}>
            <img src={archiveAssets.emblem} alt="Yemberzal emblem" className="size-10 rounded-xl object-cover" />
            <div className="leading-none"><div className="font-display text-xl">Yemberzal</div><div className="mt-1 text-[10px] uppercase text-ink/50">یَمبرزل · Field Archive</div></div>
          </Link>
          <Button variant="ghost" size="icon" className="md:hidden" onClick={() => setOpen((v) => !v)} aria-label="Open archive navigation">{open ? <X /> : <Menu />}</Button>
          <nav className="hidden flex-wrap items-center justify-end gap-1 md:flex">
            {tabs.map(([label, to]) => <Link key={to} to={to} className="rounded-full px-3 py-2 text-xs text-ink/65 transition-colors hover:bg-ink/5" activeProps={{ className: "rounded-full bg-primary px-3 py-2 text-xs text-primary-foreground" }}>{label}</Link>)}
          </nav>
        </div>
        {open && <nav className="grid grid-cols-2 gap-1 border-t border-ink/10 p-3 md:hidden">{tabs.map(([label, to]) => <Link key={to} to={to} className="rounded-lg px-3 py-2 text-sm" onClick={() => setOpen(false)} activeProps={{ className: "rounded-lg bg-primary px-3 py-2 text-sm text-primary-foreground" }}>{label}</Link>)}</nav>}
      </header>
      {children}
      <footer className="mx-4 my-8 flex flex-wrap items-center justify-between gap-3 border-t border-ink/10 pt-5 text-[11px] text-ink/50"><span>© Yemberzal Field Archive · Crowd-funded historiography</span><span>A structure survives its congregation. Whether it survives forgetting is still being decided.</span></footer>
    </div>
  );
}
