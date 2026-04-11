# InspiraVerse 🚀

> *Daily quotes that fuel your mindset and shape your future.*

InspiraVerse is a modern, production-ready mobile application delivering curated motivational quotes, daily inspiration, and highly aesthetic shareable quote cards. Designed to help users maintain a positive mindset, boost productivity, and build mental resilience.

---

## 🎯 The Problem & Our Solution
**The Problem:** Many people struggle with a lack of daily motivation, burnout, negative mindset loops, and severe distraction from social media. Existing quote apps are often outdated, ad-heavy, poorly designed, or strictly generic.

**The Solution:** InspiraVerse delivers:
- Daily curated inspirational quotes built on psychological datasets.
- A personalized, AI-driven recommendation feed.
- An aesthetic, viral share-card generator for Instagram/TikTok.
- An offline, minimal-distraction reading library.

## ✨ Core Features
- **Daily Inspiration Engine:** Push notifications tailored to your local timezone.
- **Categorized Feeds:** Filter by Success, Resilience, Mindset, Leadership, etc.
- **Offline Mode:** Hive-powered local caching ensures you have quotes on an airplane or subway.
- **Shareable Cards:** High-quality gradient text-image exports.
- **Dark Mode:** Sleek, automatic dark mode support.
- **Freemium Ready:** Setup for premium feature unlocking.

---

## 🛠 Tech Stack
**Frontend (Mobile App)**
- **Framework:** Flutter (Dart)
- **State Management:** Riverpod 2.x
- **Local Storage:** Hive
- **Routing:** GoRouter

**Backend (Serverless)**
- **Database:** Firebase Firestore
- **API:** Firebase Cloud Functions (Node.js)
- **Auth & Analytics:** Firebase Auth, Firebase Analytics
- **Push Notifications:** Firebase Cloud Messaging (FCM)

**Web (Landing Page)**
- **Framework:** Next.js 14, React 18
- **Styling:** TailwindCSS
- **Deployment:** Vercel

---

## 🏗 System Architecture
The application runs on a purely serverless infrastructure designed for high scalability and low latency:
1. **Flutter App** queries **Firestore** SDK or **Cloud Functions** endpoints.
2. Data is cached locally using **Hive** for offline availability.
3. **Firebase Cloud Messaging** sends scheduled daily quote triggers.
4. **Firebase Analytics** logs user shares and favorites to update the global `popularity_score` of each quote in real-time.

---

## 🚀 Setup Instructions

### 1. Mobile App Setup
```bash
cd mobile_app
flutter pub get
flutter run
```
*(Note: You must add your own `google-services.json` / `GoogleService-Info.plist` to link your Firebase project).*

### 2. Backend Setup
```bash
cd backend/functions
npm install
firebase deploy --only functions
```
*(Note: Requires Firebase CLI installed and an active project).*

### 3. Landing Page Setup
```bash
cd landing_page
npm install
npm run dev
```

---

## 📈 Roadmap & KPI Strategy
**Initial Target Goal:** 10,000 installs within 3 months.
- **Phase 1 (MVP):** Daily quotes, offline mode, basic share cards.
- **Phase 2 (Growth):** Advanced streak system, lock-screen widgets, AI-generated custom quotes.
- **Phase 3 (Monetization):** Premium quote packs (Business, Stoicism, specialized psychology), animated share cards.

**Growth Channels:**
- TikTok/Reels motivation content showcasing the app's aesthetic UI.
- Automation of Instagram quote sharing via the viral Share Card feature.
- Productivity influencer micro-sponsorships.

---

## 💰 Monetization Strategy
We utilize a **Freemium** model.
- **Free Tier:** Access to daily quotes, basic categories, standard share card exports.
- **InspiraVerse Premium:** Ad-free UX, exclusive profound quote packs, premium gradient/animated themes for share cards, unlimited favorites.

## 🤝 Contribution Guidelines
This repository is currently closed-source for production purposes. 
*Architected and developed as a complete product blueprint.*
