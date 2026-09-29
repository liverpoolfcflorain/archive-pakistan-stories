CREATE TYPE public.app_role AS ENUM ('admin', 'editor');
CREATE TYPE public.media_kind AS ENUM ('image', 'audio', 'video');
CREATE TYPE public.inquiry_kind AS ENUM ('tour', 'tourism', 'contribution', 'general');

CREATE TABLE public.user_roles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  role public.app_role NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, role)
);
GRANT SELECT ON public.user_roles TO authenticated;
GRANT ALL ON public.user_roles TO service_role;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.has_role(_user_id uuid, _role public.app_role)
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
GRANT EXECUTE ON FUNCTION public.has_role(uuid, public.app_role) TO authenticated;
GRANT EXECUTE ON FUNCTION public.has_role(uuid, public.app_role) TO service_role;

CREATE POLICY "Users can read their own role"
ON public.user_roles FOR SELECT TO authenticated
USING (user_id = auth.uid());
CREATE POLICY "Admins can manage roles"
ON public.user_roles FOR ALL TO authenticated
USING (public.has_role(auth.uid(), 'admin'))
WITH CHECK (public.has_role(auth.uid(), 'admin'));

CREATE TABLE public.heritage_sites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text NOT NULL UNIQUE,
  register_number integer NOT NULL UNIQUE,
  title text NOT NULL,
  location text NOT NULL DEFAULT '',
  site_type text NOT NULL DEFAULT '',
  period text NOT NULL DEFAULT '',
  summary text NOT NULL DEFAULT '',
  description text NOT NULL DEFAULT '',
  archaeological_significance text NOT NULL DEFAULT '',
  cultural_significance text NOT NULL DEFAULT '',
  religious_significance text NOT NULL DEFAULT '',
  historical_significance text NOT NULL DEFAULT '',
  map_x numeric NOT NULL DEFAULT 50,
  map_y numeric NOT NULL DEFAULT 50,
  published boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.heritage_sites TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON public.heritage_sites TO authenticated;
GRANT ALL ON public.heritage_sites TO service_role;
ALTER TABLE public.heritage_sites ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published sites are public"
ON public.heritage_sites FOR SELECT TO anon, authenticated
USING (published OR public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins manage sites"
ON public.heritage_sites FOR ALL TO authenticated
USING (public.has_role(auth.uid(), 'admin'))
WITH CHECK (public.has_role(auth.uid(), 'admin'));

CREATE TABLE public.media_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  site_id uuid REFERENCES public.heritage_sites(id) ON DELETE CASCADE,
  kind public.media_kind NOT NULL,
  title text NOT NULL,
  language text NOT NULL DEFAULT '',
  file_path text NOT NULL,
  alt_text text NOT NULL DEFAULT '',
  credit text NOT NULL DEFAULT '',
  duration_seconds integer,
  sort_order integer NOT NULL DEFAULT 0,
  published boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.media_items TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON public.media_items TO authenticated;
GRANT ALL ON public.media_items TO service_role;
ALTER TABLE public.media_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published media records are public"
ON public.media_items FOR SELECT TO anon, authenticated
USING (published OR public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins manage media records"
ON public.media_items FOR ALL TO authenticated
USING (public.has_role(auth.uid(), 'admin'))
WITH CHECK (public.has_role(auth.uid(), 'admin'));

CREATE TABLE public.archive_sections (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  section_key text NOT NULL UNIQUE,
  title text NOT NULL,
  eyebrow text NOT NULL DEFAULT '',
  body text NOT NULL DEFAULT '',
  published boolean NOT NULL DEFAULT true,
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.archive_sections TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON public.archive_sections TO authenticated;
GRANT ALL ON public.archive_sections TO service_role;
ALTER TABLE public.archive_sections ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Published sections are public"
ON public.archive_sections FOR SELECT TO anon, authenticated
USING (published OR public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins manage sections"
ON public.archive_sections FOR ALL TO authenticated
USING (public.has_role(auth.uid(), 'admin'))
WITH CHECK (public.has_role(auth.uid(), 'admin'));

CREATE TABLE public.inquiries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  kind public.inquiry_kind NOT NULL DEFAULT 'general',
  name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL DEFAULT '',
  message text NOT NULL,
  status text NOT NULL DEFAULT 'new',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT INSERT ON public.inquiries TO anon, authenticated;
GRANT SELECT, UPDATE, DELETE ON public.inquiries TO authenticated;
GRANT ALL ON public.inquiries TO service_role;
ALTER TABLE public.inquiries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can send an inquiry"
ON public.inquiries FOR INSERT TO anon, authenticated
WITH CHECK (length(name) BETWEEN 1 AND 120 AND length(email) BETWEEN 3 AND 320 AND length(message) BETWEEN 1 AND 5000);
CREATE POLICY "Admins manage inquiries"
ON public.inquiries FOR SELECT TO authenticated
USING (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins update inquiries"
ON public.inquiries FOR UPDATE TO authenticated
USING (public.has_role(auth.uid(), 'admin'))
WITH CHECK (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "Admins delete inquiries"
ON public.inquiries FOR DELETE TO authenticated
USING (public.has_role(auth.uid(), 'admin'));

CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS trigger LANGUAGE plpgsql SET search_path = public AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$;
CREATE TRIGGER heritage_sites_updated_at BEFORE UPDATE ON public.heritage_sites FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER media_items_updated_at BEFORE UPDATE ON public.media_items FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER archive_sections_updated_at BEFORE UPDATE ON public.archive_sections FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER inquiries_updated_at BEFORE UPDATE ON public.inquiries FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

INSERT INTO public.heritage_sites (register_number, slug, title, location, site_type, period, summary, description, map_x, map_y) VALUES
(1, 'gulshan-e-shauda', 'Gurdwara Gulshan-e-Shauda', 'Rawalakot, Poonch District', 'Gurdwara / Samadhi', 'Sikh era', 'One of Rawalakot’s most important surviving Sikh-period buildings.', 'One of two Sikh-era buildings forming the core of Nimra Tariq’s 2024 study of Rawalakot’s Sikh heritage. Its masonry combines construction typical of Sikh-period hill shrines with features read as closer to a samadhi. Local oral tradition still attaches legends to the building. Today it stands unroofed and unmaintained.', 48, 39),
(2, 'gurdwara-sahib-draid', 'Gurdwara Sahib Draid', 'Draid, near Rawalakot', 'Gurdwara / Samadhi', 'Sikh era', 'A field-study companion to Gulshan-e-Shauda.', 'The second of Tariq’s two 2024 case studies, chosen alongside Gulshan-e-Shauda because together the pair span the range of construction, layout and function found among Rawalakot’s surviving Sikh-period buildings.', 52, 42),
(3, 'upper-koiyan-baoli', 'Upper Koiyan Baoli', 'Upper Koiyan, Poonch District', 'Stepwell', 'Sikh–Dogra era', 'A stone stepwell in the regional tradition of water infrastructure for hill travellers.', 'Baolis were a common feature of Sikh- and Dogra-era infrastructure across Jammu and Kashmir. The Upper Koiyan Baoli belongs to this regional tradition of stepwells serving hill travellers and villagers.', 57, 35),
(4, 'sikh-structures-poonch', 'Sikh Structures, Poonch District', 'Poonch District', 'Multiple structures', 'Sikh era', 'A wider scatter of memorial platforms, wells, walls and outbuildings.', 'Beyond the individually named sites, Rawalakot and wider Poonch preserve unnamed or informally identified Sikh-period remains clustered around the principal gurdwaras.', 46, 46),
(5, 'old-poonch', 'Old Poonch (Purani Poonch)', 'Historic Poonch', 'Fort-palace and settlement', '1713–1947', 'The pre-Partition administrative and cultural centre of the undivided Poonch jagir.', 'Before 1947, Poonch meant a single princely jagir town centred on Poonch Fort. The 1947–48 war split the old district; Rawalakot became the administrative capital for the northern territory.', 36, 48),
(6, 'baral-fort', 'Baral Fort', 'Baral, Poonch–Rajouri frontier', 'Hill fort', 'Late medieval / Dogra', 'A compact hill fort overlooking the Rajouri, Nowshera and Khui Ratta valleys.', 'Baral Fort sits on a rocky hillock and formed part of a chain of forts defending the Poonch–Rajouri frontier. Its octagonal corner towers, cusped arch and water tank survive in partial ruin.', 66, 55),
(7, 'kotli-kachayi-fort', 'Kotli Kachayi Fort', 'Kotli District', 'Hill fort', 'Mongral / Sikh / Dogra', 'A limestone hilltop fort also known in records as Qila Karchai.', 'The fort occupies a hilltop in an irregular plan built of limestone and lime mortar. It was captured by Sikh forces under Maharaja Ranjit Singh and later rebuilt in stone under Dogra rule.', 71, 61),
(8, 'seri-temple', 'Seri Temple', 'Poonch region', 'Temple', 'Historic', 'A protected temple in the regional heritage register.', 'Seri Temple appears as a formally listed entry in the Department of Archaeology and Museums heritage register, part of the documentation and protection exercise across Poonch, Kotli, Sudhnoti and Neelum.', 62, 70),
(9, 'ranbir-singh-baradari', 'Ranbir Singh Baradari', 'Muzaffarabad', 'Baradari', 'Dogra era', 'A riverside pavilion associated with Maharaja Ranbir Singh.', 'The pavilion stands near the river confluence at Muzaffarabad and represents the Dogra-era architectural layer within the wider regional field register.', 77, 23),
(10, 'gurdwara-chatti-badshahi', 'Gurdwara Chatti Badshahi', 'Azad Jammu and Kashmir', 'Gurdwara', 'Sikh era', 'A Sikh sacred site included in the wider AJK heritage record.', 'Gurdwara Chatti Badshahi belongs to the sacred geography of Sikh memory in the region and is included here as part of the comparative field register.', 41, 67);

INSERT INTO public.archive_sections (section_key, title, eyebrow, body) VALUES
('concept', 'A living archive of the Poonch valley, told in the voice of its stones.', 'Concept note', 'Yemberzal documents the forgotten Sikh history of Kashmir through field research, photographs, maps and oral testimony. The archive begins with ten structures and remains open to evidence contributed by the communities who live around them.'),
('mission', 'A structure survives its congregation. Whether it survives forgetting is still being decided.', 'Mission statement', 'Our mission is to preserve a public, multilingual record of Sikh, Dogra and shared heritage across the Poonch landscape through crowd-funded historiography.'),
('archaeological', 'Structures and strata', 'Archaeological significance', 'The archive records masonry, plans, water systems, building phases, condition and evidence of reuse across forts, baolis, gurdwaras, temples and civic structures.'),
('cultural', 'Pahari memory', 'Cultural significance', 'Place-names, oral traditions, community memories and everyday encounters keep these structures legible even where formal records are incomplete.'),
('religious', 'Sacred sites after displacement', 'Religious significance', 'Gurdwaras, temples and memorial structures preserve the sacred geography of communities displaced in 1947, while continuing to be remembered by present-day residents.'),
('historical', 'From construction to rediscovery', 'Historical significance', 'The field register follows the region from early Poonch rulers through Sikh and Dogra periods, Partition, legal protection and contemporary documentation.');