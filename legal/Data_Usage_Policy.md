# Data Usage Policy

**Last Updated: April 2026**

This Data Usage Policy details exactly what data InspiraVerse collects and how we handle it, ensuring full compliance with Google Play Store Developer Policies.

## 1. Core Principle
InspiraVerse believes in extreme transparency. We only collect data that directly improves the user experience. **We do not sell user data to advertising brokers.**

## 2. High-Utility Features & Analytics
We utilize **Firebase Analytics** and local storage to power high-value features:
- **Mindset Journey (Tracking):** Personal reflections and streaks are stored **locally**. Aggregated, anonymized participation data may be used to improve app engagement.
- **Designer Studio (Creation):** Custom quotes you create using our Designer Studio are stored on your device gallery or dedicated app storage. We do not store these images on our servers.
- **Actionable Notifications:** Our daily quotes may include "Share" actions. Interacting with these logs a generic "share" event for analytics.

*Why?* These interactive features ensure InspiraVerse provides a unique, high-utility experience that goes beyond static content.

## 3. Push Notifications Usage
We utilize **Firebase Cloud Messaging (FCM)**.
- **Frequency:** Once daily.
- **Content:** A single motivational quote or a reminder to complete your "Mindset Journey" reflection.
- **Opt-out:** Users can disable this in Settings > Profile at any time.

## 4. On-Device Storage (Hive)
We use the **Hive** encrypted on-device database to:
- Cache quotes for offline access.
- Store your personal **Mindset Journey** reflections and streaks locally.
- Persist your app preferences and Designer Studio configurations.

## 5. Account Data
If a user creates an account:
- We store an email address strictly for authentication and syncing favorites across devices.
- Users have a permanent "Delete Account" button in the app profile that purges all Firestore data tied to their UID instantly.

## 6. Children's Privacy
InspiraVerse is designed for general audiences. However, we do not knowingly collect personal information from children under 13.
