CREATE POLICY "Public can read heritage media"
ON storage.objects FOR SELECT TO anon, authenticated
USING (bucket_id = 'heritage-media');
CREATE POLICY "Admins can upload heritage media"
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'heritage-media' AND private.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can update heritage media"
ON storage.objects FOR UPDATE TO authenticated
USING (bucket_id = 'heritage-media' AND private.has_role(auth.uid(), 'admin'))
WITH CHECK (bucket_id = 'heritage-media' AND private.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins can delete heritage media"
ON storage.objects FOR DELETE TO authenticated
USING (bucket_id = 'heritage-media' AND private.has_role(auth.uid(), 'admin'));