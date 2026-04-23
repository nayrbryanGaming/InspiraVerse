# InspiraVerse 🌌
> Daily quotes that fuel your mindset and shape your future.

[![Build Status](https://img.shields.io/badge/Version-1.0.0%2B18-blueviolet)](https://github.com/nayrbryanGaming/InspiraVerse)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#)
[![Compliance](https://img.shields.io/badge/Google_Play-Compliant-green)](https://play.google.com/store)

## 🚀 Product Overview
InspiraVerse is a premium mobile experience designed to combat mental fatigue and distraction. By delivering curated psychological insights and aesthetic mindfulness tools, we help users build unshakeable mental resilience.

### The Problem
- **Mental Fatigue**: Users are overwhelmed by social media noise.
- **Lack of Focus**: No dedicated space for high-quality, curated wisdom.
- **Generic Apps**: Most quote apps are ad-heavy and poorly designed.

### The Solution
- **Curated Datasets**: Psychological-grade quote library.
- **Personalized Feed**: Content tailored to your current mindset.
- **Designer Studio**: Create and share viral-ready quote cards.
- **Offline Sovereignty**: Full functionality without an internet connection.

---

## 🛠️ Tech Stack
- **Frontend**: Flutter (Latest Stable) + Dart
- **State Management**: Riverpod (Reactive Architecture)
- **Backend**: Firebase (Firestore, Cloud Functions, Auth)
- **Local Storage**: Hive (High-Performance NoSQL)
- **Landing Page**: Next.js + TailwindCSS

---

## 🏗️ Architecture
The app follows **Clean Architecture** principles:
- **Core**: Cross-cutting concerns (Services, Themes, Constants).
- **Features**: Domain-driven modules (Auth, Quotes, Designer, Journey).
- **Models**: Immutable data structures (Equatable).
- **Widgets**: Reusable UI components.

---

## 🚦 Setup Instructions

### Prerequisites
- Flutter SDK (>=3.2.0)
- Firebase Account
- Node.js (for backend functions)

### Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/nayrbryanGaming/InspiraVerse.git
   ```
2. **Mobile Setup**:
   - `cd mobile_app`
   - `flutter pub get`
   - Create `android/key.properties` (see template).
   - Inject your Firebase keys into `lib/firebase_options.dart`.
3. **Backend Setup**:
   - `cd backend/functions`
   - `npm install`
   - `firebase deploy --only functions`

---

## 📈 Roadmap & Monetization
- **Phase 1**: Initial Launch (10,000 Installs).
- **Phase 2**: Premium Quote Packs (Stoicism, High Performance).
- **Phase 3**: AI-Generated Personalized Affirmations.

**Revenue Model**: Freemium with monthly/yearly subscriptions for premium themes and exclusive quote datasets.

---

## ⚖️ Legal & Compliance
- [Privacy Policy](legal/privacy_policy.md)
- [Terms of Service](legal/terms_of_service.md)
- [Data Usage Policy](legal/data_usage_policy.md)

---

© 2026 InspiraVerse Labs. Crafted for the modern mind.
