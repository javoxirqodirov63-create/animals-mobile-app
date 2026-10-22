# Hayvonlar Savdosi Platformasi (Animal Marketplace): Brainstorm va Rejalashtirish Qaydlari
Sana: 2026-10-16 · Maqsad: Odamlar hayvonlarni xavfsiz va qulay sotishi hamda sotib olishi uchun mo'ljallangan ilova konsepsiyasini aniqlash va loyihalashtirish.

## Asosiy qarorlar va xulosa
- **Loyiha nomi**: **Animals-uz** (Universal hayvonlar va chorva mollari savdosi platformasi).
- **Qamrov (MVP Scope)**: Dastlab sof hayvonlar oldi-sotdisiga fokuslaniladi. Qo'shimcha xizmatlar (yem-xashak, zootovarlar, veterinarlar) keyingi bosqichlarga qoldiriladi.
- **Platforma formati**: Alohida kross-platforma Mobil Ilova (Android va iOS uchun Flutter asosida), do'konlar (Google Play va App Store) orqali tarqatiladi.
- **Texnologik stek**:
  - **Frontend / Mobil**: Flutter (Dart) — bitta kod bazasi orqali Android va iOS uchun zamonaviy, tez va chiroyli interfeys.
  - **Backend / Ma'lumotlar bazasi**: Supabase / Firebase — tayyor autentifikatsiya (SMS/OTP), real-time ma'lumotlar bazasi, rasmlar uchun Cloud Storage va tezkor ishga tushirish (MVP).
- **Savdo va muloqot modeli**: E'lonlar va to'g'ridan-to'g'ri aloqa (Classifieds). Xaridor va sotuvchi ichki chat yoki telefon orqali to'g'ridan-to'g'ri bog'lanadi, hayvonni borib ko'rib joyida kelishadi. Bu tirik jonivorlar uchun eng ishonchli va nizosiz usul.
- **E'lon joylash soddaligi**: Maksimal yengil va oddiy e'lon formati (Rasm, narx, tavsif, hudud va telefon raqam). Ortiqcha byurokratiya va majburiy hujjatlar talab etilmaydi — bu sotuvchilar sonini tez ko'paytirish uchun eng yaxshi strategiya.
- **Hududiy qidiruv va filtrlash**: O'zbekistonning barcha Viloyat va Tumanlari ro'yxati bo'yicha saralash. Foydalanuvchi o'z tumani/viloyatidagi e'lonlarni bir bosishda topa oladi.
- **Monetizatsiya strategiyasi**: Dastlab 100% mutlaqo bepul (Growth-first). Asosiy e'tibor foydalanuvchilar sonini tezkor o'stirish va platformaga odatlarni shakllantirishga qaratiladi; pullik xizmatlar (TOP/VIP, reklama) keyingi bosqichlarda ulanadi.
- **Foydalanuvchi kirishi (Auth)**: Mehmon rejimi (Guest Mode) mavjud — xaridorlar e'lonlarni erkin ko'rib, qidirib foydalanaveradi. Faqatgina yangi e'lon qo'ymoqchi yoki sevimlilarga saqlamoqchi bo'lganda Telefon raqam + SMS kod orqali tezkor autentifikatsiya qilinadi.

## Savol-javoblar jurnali (Q&A log)
### Q1 — Maqsadli hayvonlar toifasi
- **Savol**: Platformangiz dastlab asosan qaysi turdagi hayvonlar savdosiga ixtisoslashgan bo'lishini xohlaysiz?
- **Javob**: Universal bozor (ham uy hayvonlari, ham chorva hayvonlari birgalikda).
- **Qaydlar/Flags**: Universal platforma auditoriyasi 2 xil bo'ladi: shahar yoshlari/oila (uy hayvonlari) va viloyat/qishloq fermerlari (chorva). Ilova tushunarli va murakkab bo'lmagan bo'lishi shart.

### Q2 — Platforma formati
- **Savol**: Ilovani qaysi platforma/formatda boshlashni ma'qul ko'rasiz?
- **Javob**: Alohida Mobil Ilova (Android va iOS / Flutter orqali do'konlarga chiqarish).
- **Qaydlar/Flags**: Alohida mobil ilova push-bildirishnomalar (yangi e'lonlar, xabarlar), offline kesh va qulay kamera integratsiyasi (hayvonlarni rasm/videoga olib darhol yuklash) uchun ajoyib qulaylik beradi.

### Q3 — Savdo va aloqa modeli
- **Savol**: Xaridor va sotuvchi o'rtasidagi savdo va aloqa qanday tartibda amalga oshishini xohlaysiz?
- **Javob**: E'lonlar va to'g'ridan-to'g'ri aloqa (Xaridor sotuvchi bilan ilova ichidagi chat yoki telefon orqali bog'lanadi, borib ko'rib joyida kelishadi).
- **Qaydlar/Flags**: Ilova ichida qulay ichki chat (xabarlar, rasm/video jo'natish) va sotuvchining telefon raqamini ko'rsatish/yashirish funksiyasi kerak bo'ladi.

### Q4 — E'lon formati va ishonch mexanizmi
- **Savol**: Hayvonlar sog'lig'i va soxta e'lonlarning oldini olish (ishonch) uchun qanday mexanizm qo'llaymiz?
- **Javob**: Oddiy e'lon formati (Faqat rasm, narx va telefon raqam — sotuvchilar uchun e'lon qo'yish maksimal oson bo'ladi).
- **Qaydlar/Flags**: Fermerlar va oddiy sotuvchilar uchun kirish to'sig'i minimal bo'ladi. Qoidabuzar yoki soxta e'lonlar uchun oddiy "Shikoyat qilish (Report)" tugmasi va moderator tekshiruvi yetarli bo'ladi.

### Q5 — Hududiy qidiruv mexanizmi
- **Savol**: Xaridorlar o'zlariga yaqin hududdagi hayvonlarni qanday usulda qidirishi va filtrlashi kerak?
- **Javob**: Viloyat va Tumanlar ro'yxati orqali (Foydalanuvchi viloyat va tumanini tanlaydi — O'zbekiston sharoitida eng qulay va aniq usul).
- **Qaydlar/Flags**: Ilova ma'lumotlar bazasida O'zbekistonning 14 ta ma'muriy hududi (12 viloyat + Toshkent sh. + Qoraqalpog'iston) va ularning 200+ tuman/shaharlari ro'yxati oldindan kiritilgan bo'ladi.

### Q6 — Monetizatsiya (daromad) strategiyasi
- **Savol**: Ilovadan qanday qilib daromad olishni (monetizatsiyani) rejalashtiryapsiz?
- **Javob**: Dastlab 100% mutlaqo bepul (Dastlab foydalanuvchilarni ko'paytirish, monetizatsiyani keyinroq ulash).
- **Qaydlar/Flags**: Boshlang'ich versiyada to'lov shlyuzlari (Payme/Click) integratsiyasiga vaqt sarflanmaydi, bu ilovani tezroq ishga tushirish (MVP) imkonini beradi.

### Q7 — Foydalanuvchi avtorizatsiyasi va onboarding
- **Savol**: Foydalanuvchilar ilovaga kirishi va ro'yxatdan o'tishi qanday tashkil etilsin?
- **Javob**: E'lonlarni ko'rish erkin (mehmon rejimi), e'lon qo'yish uchun Telefon raqam (SMS kod) orqali tezkor kirish.
- **Qaydlar/Flags**: Foydalanuvchilarga to'siq qo'ymaslik uchun ilovani ochishi bilan ro'yxatdan o'tishni majburlamaymiz. Faqat aktiv harakat (e'lon berish, xabar yozish, sevimlilarga qo'shish) vaqtida telefon so'raladi.

### Q8 — Texnologik stek
- **Savol**: Ilovani ishlab chiqishda texnologik stek va server bo'yicha qaysi yo'nalishni tanlaymiz?
- **Javob**: Flutter (Mobil ilova) + Supabase/Firebase.
- **Qaydlar/Flags**: Ishlab chiqish tezligi yuqori, xarajatlar minimal, avtomatik masshtablash (scaling) imkoniyati bor.

### Q9 — Mahsulot va xizmatlar qamrovi (Scope)
- **Savol**: Ilovada faqat hayvonlarning o'zi sotiladimi yoki qo'shimcha mahsulot va xizmatlar ham bo'lishi kerakmi?
- **Javob**: Dastlab faqat hayvonlar savdosi (MVP — ortiqcha murakkabliklarsiz faqat hayvon oldi-sotdisiga fokuslanish).
- **Qaydlar/Flags**: Birinchi versiyada diqqatni faqat hayvonlar katalogi, qidiruv va aloqaga qaratamiz. Do'konlar va veterinarlar keyingi yangilanishlarda qo'shiladi.

## Ochiq qolgan masalalar (Open flags)
- *Barcha dastlabki masalalar to'liq kelishildi va loyihaning poydevor talablari aniqlandi.*
