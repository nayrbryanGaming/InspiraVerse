# Data Usage Policy

**Last Updated: April 2026**

This Data Usage Policy details exactly what data InspiraVerse collects and how we handle it, ensuring full compliance with Google Play Store Developer Policies.

## 1. Core Principle
InspiraVerse believes in extreme transparency. We only collect data that directly improves the user experience. **We do not sell user data to advertising brokers.**

## 2. Analytics Disclosure
We utilize **Firebase Analytics** to track:
- App crashes and performance issues.
- Which quote categories are most popular.
- Daily active usage to measure product retention.
- Sharing frequency (to see which quotes are resonant).

*Why?* This helps us curate better psychological datasets and improve app stability.

## 3. Push Notifications Usage
We utilize **Firebase Cloud Messaging (FCM)**.
- We request explicit permission to send notifications.
- Notifications are used EXCLUSIVELY to send "Daily Inspiration" quotes based on user-defined schedules.
- We do not use push notifications for third-party advertising or spam.

## 4. On-Device Storage
We use local storage (Hive database) to cache quotes. This allows the app to function flawlessly offline over extended periods without scraping background data.

## 5. Account Data
If a user creates an account:
- We store an email address strictly for authentication and syncing favorites across devices.
- Users have a permanent "Delete Account" button in the app profile that purges all Firestore data tied to their UID instantly.

## 6. Children's Privacy
InspiraVerse is designed for general audiences. However, we do not knowingly collect personal information from children under 13.
