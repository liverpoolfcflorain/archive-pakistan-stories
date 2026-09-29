CREATE SCHEMA IF NOT EXISTS private;
REVOKE ALL ON SCHEMA private FROM PUBLIC;
GRANT USAGE ON SCHEMA private TO authenticated, service_role;

CREATE OR REPLACE FUNCTION private.has_role(_user_id uuid, _role public.app_role)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles
    WHERE user_id = _user_id AND role = _role
  )
$$;
REVOKE ALL ON FUNCTION public.has_role(uuid, public.app_role) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION private.has_role(uuid, public.app_role) TO authenticated, service_role;

ALTER POLICY "Admins can manage roles" ON public.user_roles
USING (private.has_role(auth.uid(), 'admin'))
WITH CHECK (private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Published sites are public" ON public.heritage_sites
USING (published OR private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Admins manage sites" ON public.heritage_sites
USING (private.has_role(auth.uid(), 'admin'))
WITH CHECK (private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Published media records are public" ON public.media_items
USING (published OR private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Admins manage media records" ON public.media_items
USING (private.has_role(auth.uid(), 'admin'))
WITH CHECK (private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Published sections are public" ON public.archive_sections
USING (published OR private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Admins manage sections" ON public.archive_sections
USING (private.has_role(auth.uid(), 'admin'))
WITH CHECK (private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Admins manage inquiries" ON public.inquiries
USING (private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Admins update inquiries" ON public.inquiries
USING (private.has_role(auth.uid(), 'admin'))
WITH CHECK (private.has_role(auth.uid(), 'admin'));
ALTER POLICY "Admins delete inquiries" ON public.inquiries
USING (private.has_role(auth.uid(), 'admin'));

DROP FUNCTION public.has_role(uuid, public.app_role);