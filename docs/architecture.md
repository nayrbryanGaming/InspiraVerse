# InspiraVerse System Architecture

## Overview
InspiraVerse follows a modern, serverless architecture designed for global scalability and high availability.

## 1. Mobile Client (Flutter)
The frontend is built with Flutter, utilizing **Riverpod** for reactive state management.
- **Features**: Authentication, Quote Feed, Designer Studio, Resilience Journey.
- **Local Storage**: **Hive** is used for high-performance offline caching.
- **Service Layer**: Decoupled service layer for Firebase interactions.

## 2. Backend (Firebase)
- **Firebase Auth**: Secure user authentication (Email/Social).
- **Firestore**: Scalable NoSQL database for quotes and user activity.
- **Cloud Functions**: Node.js based serverless functions for business logic.
- **FCM**: Push notifications for daily inspiration.

## 3. Data Flow
1. User requests feed.
2. App checks local Hive cache.
3. App fetches from Firestore via Cloud Functions.
4. Analytics logged to Firebase Analytics.

## 4. Compliance & Security
- **Data Safety**: End-to-end encryption for private journals.
- **Recursive Purge**: Automated Cloud Function to delete all user-related data clusters on account deletion.
