DROP POLICY IF EXISTS "Public can read heritage media" ON storage.objects;
CREATE POLICY "Admins can read heritage media"
ON storage.objects FOR SELECT TO authenticated
USING (bucket_id = 'heritage-media' AND private.has_role(auth.uid(), 'admin'::app_role));