-- ===================================================
-- Chorva & Jonivorlar Bozori (Supabase Database Sxemasi)
-- Ushbu SQL kodini supabase.com da SQL Editor bo'limida 1 marta ishga tushiring (Run)
-- ===================================================

-- 1. E'lonlar jadvali (listings)
CREATE TABLE IF NOT EXISTS public.listings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL,
    currency VARCHAR(10) DEFAULT 'UZS',
    is_negotiable BOOLEAN DEFAULT true,
    category_id INT NOT NULL,
    category_name TEXT NOT NULL,
    region_id INT NOT NULL,
    region_name TEXT NOT NULL,
    district_id INT NOT NULL,
    district_name TEXT NOT NULL,
    contact_phone VARCHAR(30) NOT NULL,
    seller_name VARCHAR(100) DEFAULT 'Foydalanuvchi',
    image_urls TEXT[] DEFAULT '{}',
    views_count INT DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Tezkor qidiruv indekslari
CREATE INDEX IF NOT EXISTS idx_listings_category ON public.listings(category_id);
CREATE INDEX IF NOT EXISTS idx_listings_region ON public.listings(region_id);
CREATE INDEX IF NOT EXISTS idx_listings_created_at ON public.listings(created_at DESC);

-- 3. Xavfsizlik qoidalari (Row Level Security - RLS)
ALTER TABLE public.listings ENABLE ROW LEVEL SECURITY;

-- Hamma o'qiy oladi (Public Read)
CREATE POLICY "E'lonlarni hamma ko'ra oladi" 
ON public.listings FOR SELECT 
USING (true);

-- Hamma yangi e'lon qo'sha oladi (Public Insert)
CREATE POLICY "Hamma yangi e'lon qo'sha oladi" 
ON public.listings FOR INSERT 
WITH CHECK (true);
