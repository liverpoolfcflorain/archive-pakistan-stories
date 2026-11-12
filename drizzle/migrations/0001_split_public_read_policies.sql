DROP POLICY "Published sites are public" ON public.heritage_sites;
CREATE POLICY "Visitors read published sites" ON public.heritage_sites FOR SELECT TO anon USING (published);
CREATE POLICY "Signed-in read published sites or admin all" ON public.heritage_sites FOR SELECT TO authenticated
USING (published OR public.has_role(auth.uid(), 'admin'));

DROP POLICY "Published media records are public" ON public.media_items;
CREATE POLICY "Visitors read published media records" ON public.media_items FOR SELECT TO anon USING (published);
CREATE POLICY "Signed-in read published media or admin all" ON public.media_items FOR SELECT TO authenticated
USING (published OR public.has_role(auth.uid(), 'admin'));

DROP POLICY "Published sections are public" ON public.archive_sections;
CREATE POLICY "Visitors read published sections" ON public.archive_sections FOR SELECT TO anon USING (published);
CREATE POLICY "Signed-in read published sections or admin all" ON public.archive_sections FOR SELECT TO authenticated
USING (published OR public.has_role(auth.uid(), 'admin'));