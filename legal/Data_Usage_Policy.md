# Data Usage Policy

**Last Updated: April 2026**

This Data Usage Policy details exactly what data InspiraVerse collects and how we handle it, ensuring full compliance with Google Play Store Developer Policies.

## 1. Core Principle
InspiraVerse believes in extreme transparency. We only collect data that directly improves the user experience. **We do not sell user data to advertising brokers.**

## 2. High-Utility Features & Analytics
We utilize **Firebase Analytics** and local storage to power high-value features:
- **Mindset Mirror (Journaling):** We collect reflection data ONLY on your local device. This data is not transmitted to our servers unless you explicitly opt-in to Cloud Sync.
- **Mood Insights:** We track which moods are selected to improve our recommendation engine (anonymized).
- **Popularity Scoring:** We log favorites and shares (without personal identifiers) to rank quotes for the community.

*Why?* These interactive features ensure InspiraVerse provides a unique, high-utility experience that goes beyond static content.

## 3. Push Notifications Usage
We utilize **Firebase Cloud Messaging (FCM)**.
- **Frequency:** Once daily.
- **Content:** A single motivational quote or a reminder to complete your "Mindset Mirror" reflection.
- **Opt-out:** Users can disable this in Settings > Profile at any time.

## 4. On-Device Storage (Hive)
We use the **Hive** encrypted on-device database to:
- Cache quotes for offline access (Subway/Airplane mode).
- Store your personal **Mindset Mirror** reflections locally.
- Persist your app preferences (Theme, Notification times).

## 5. Account Data
If a user creates an account:
- We store an email address strictly for authentication and syncing favorites across devices.
- Users have a permanent "Delete Account" button in the app profile that purges all Firestore data tied to their UID instantly.

## 6. Children's Privacy
InspiraVerse is designed for general audiences. However, we do not knowingly collect personal information from children under 13.
