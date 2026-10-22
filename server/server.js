const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.PORT || 5000;
const DATA_DIR = path.join(__dirname, 'data');
const DATA_FILE = path.join(DATA_DIR, 'listings.json');

// Papka va fayl mavjudligini ta'minlash
if (!fs.existsSync(DATA_DIR)) {
  fs.mkdirSync(DATA_DIR, { recursive: true });
}

// Boshlang'ich ma'lumotlar
const initialListings = [
  {
    id: '1',
    title: 'Zotli Hisori qo\'chqor (1 yosh, boqilgan)',
    description: 'Tirik vazni 85 kg atrofida. Dumalari katta, toza hisori zotidan. Vaksina va ukollari o\'z vaqtida qilingan, sog\'lom. Kelib ko\'rib savdolashishingiz mumkin.',
    price: 4800000,
    currency: 'UZS',
    is_negotiable: true,
    category_id: 1,
    category_name: 'Chorva mollari',
    region_id: 3,
    region_name: 'Samarqand viloyati',
    district_id: 316,
    district_name: 'Urgut tumani',
    contact_phone: '+998 90 123 45 67',
    seller_name: 'Jahongir aka',
    image_urls: [
      'https://images.unsplash.com/photo-1484557052118-f32bd25b45b5?auto=format&fit=crop&w=800&q=80'
    ],
    views_count: 142,
    created_at: new Date(Date.now() - 3 * 3600 * 1000).toISOString()
  },
  {
    id: '2',
    title: 'Shvis zotli ser-sut sigir (2-bolasi bilan)',
    description: 'Kuniga 18-20 litr sut beradi. Bolasi xunajin, 1 oylik. Yuvosh, sog\'lom, yeyish-ichishi zo\'r. Haqiqiy ro\'zgorbop mol.',
    price: 19500000,
    currency: 'UZS',
    is_negotiable: true,
    category_id: 1,
    category_name: 'Chorva mollari',
    region_id: 2,
    region_name: 'Toshkent viloyati',
    district_id: 218,
    district_name: 'Zangiota tumani',
    contact_phone: '+998 93 987 65 43',
    seller_name: 'Rustam fermer',
    image_urls: [
      'https://images.unsplash.com/photo-1546445317-29f4545e9d53?auto=format&fit=crop&w=800&q=80'
    ],
    views_count: 310,
    created_at: new Date(Date.now() - 6 * 3600 * 1000).toISOString()
  },
  {
    id: '3',
    title: 'Shotland buklama quloq (Scottish Fold) mushukchasi',
    description: '2 oylik, latok (qum)ga o\'rgatilgan. Parazitlarga qarshi dori berilgan. Ota-onasi toza zotli shotlandlar. O\'yinqaroq va mehribon.',
    price: 1300000,
    currency: 'UZS',
    is_negotiable: false,
    category_id: 3,
    category_name: 'Uy hayvonlari',
    region_id: 1,
    region_name: 'Toshkent shahri',
    district_id: 102,
    district_name: 'Chilonzor tumani',
    contact_phone: '+998 97 555 44 33',
    seller_name: 'Madina',
    image_urls: [
      'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=800&q=80'
    ],
    views_count: 220,
    created_at: new Date(Date.now() - 12 * 3600 * 1000).toISOString()
  },
  {
    id: '4',
    title: 'Toza qonli Nemis Ovcharkasi (German Shepherd) kuchukchalari',
    description: '1.5 oylik kuchukchalar. Suyaklari baquvvat, quloqlari shakllangan. Ota-onasi xizmat itlari, shajarasi (pedigree) bor.',
    price: 2800000,
    currency: 'UZS',
    is_negotiable: true,
    category_id: 3,
    category_name: 'Uy hayvonlari',
    region_id: 4,
    region_name: 'Farg\'ona viloyati',
    district_id: 403,
    district_name: 'Qo\'qon shahri',
    contact_phone: '+998 91 222 33 44',
    seller_name: 'Otabek',
    image_urls: [
      'https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?auto=format&fit=crop&w=800&q=80'
    ],
    views_count: 450,
    created_at: new Date(Date.now() - 24 * 3600 * 1000).toISOString()
  },
  {
    id: '5',
    title: 'Brahma zotli naslli tovuq va xo\'rozlar',
    description: 'Parrandachilik fermasidan sog\'lom va vazndor Brahma tovuqlar. Tuxum berishi yaxshi, patlari toza. Donabay yoki ulgurji sotiladi.',
    price: 320000,
    currency: 'UZS',
    is_negotiable: true,
    category_id: 2,
    category_name: 'Parrandalar',
    region_id: 5,
    region_name: 'Andijon viloyati',
    district_id: 504,
    district_name: 'Asaka tumani',
    contact_phone: '+998 94 333 77 88',
    seller_name: 'Dilshodbek',
    image_urls: [
      'https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?auto=format&fit=crop&w=800&q=80'
    ],
    views_count: 180,
    created_at: new Date(Date.now() - 28 * 3600 * 1000).toISOString()
  },
  {
    id: '6',
    title: 'Qorabayir zotli toychaq (2 yoshli sarig\' ot)',
    description: 'Bo\'yi baland, qad-qomati kelishgan, chopqir zot. Ko\'pkari va uloqqa moslashtirsa bo\'ladi. Oyoqlari toza, nuqsoni yo\'q.',
    price: 24000000,
    currency: 'UZS',
    is_negotiable: true,
    category_id: 1,
    category_name: 'Chorva mollari',
    region_id: 8,
    region_name: 'Qashqadaryo viloyati',
    district_id: 808,
    district_name: 'Koson tumani',
    contact_phone: '+998 90 777 88 99',
    seller_name: 'Shavkat polvon',
    image_urls: [
      'https://images.unsplash.com/photo-1553284965-83fd3e82fa5f?auto=format&fit=crop&w=800&q=80'
    ],
    views_count: 620,
    created_at: new Date(Date.now() - 48 * 3600 * 1000).toISOString()
  }
];

if (!fs.existsSync(DATA_FILE)) {
  fs.writeFileSync(DATA_FILE, JSON.stringify(initialListings, null, 2), 'utf-8');
}

function readListings() {
  try {
    const data = fs.readFileSync(DATA_FILE, 'utf-8');
    return JSON.parse(data);
  } catch (err) {
    return [];
  }
}

function writeListings(listings) {
  fs.writeFileSync(DATA_FILE, JSON.stringify(listings, null, 2), 'utf-8');
}

const server = http.createServer((req, res) => {
  // CORS sarlavhalari
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, DELETE, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  const url = new URL(req.url, `http://${req.headers.host}`);

  // 1. Health check
  if (url.pathname === '/api/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok', app: 'Animals-uz Server' }));
    return;
  }

  // 2. GET /api/listings
  if (url.pathname === '/api/listings' && req.method === 'GET') {
    const listings = readListings();
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(listings));
    return;
  }

  // 3. POST /api/listings
  if (url.pathname === '/api/listings' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const item = JSON.parse(body);
        const listings = readListings();
        
        const newListing = {
          id: item.id || Date.now().toString(),
          title: item.title || '',
          description: item.description || '',
          price: Number(item.price) || 0,
          currency: item.currency || 'UZS',
          is_negotiable: item.is_negotiable !== undefined ? item.is_negotiable : true,
          category_id: item.category_id || 1,
          category_name: item.category_name || '',
          region_id: item.region_id || 1,
          region_name: item.region_name || '',
          district_id: item.district_id || 1,
          district_name: item.district_name || '',
          contact_phone: item.contact_phone || '',
          seller_name: item.seller_name || 'Foydalanuvchi',
          image_urls: item.image_urls || [
            'https://images.unsplash.com/photo-1546445317-29f4545e9d53?auto=format&fit=crop&w=800&q=80'
          ],
          views_count: 0,
          created_at: new Date().toISOString()
        };

        listings.unshift(newListing);
        writeListings(listings);

        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true, listing: newListing }));
      } catch (err) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Noto\'g\'ri JSON ma\'lumoti' }));
      }
    });
    return;
  }

  // 4. Boshqa yo'llar
  res.writeHead(404, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({ error: 'Yo\'nalish topilmadi' }));
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`Animals-uz Server http://localhost:${PORT} manzilida ishga tushdi!`);
});
