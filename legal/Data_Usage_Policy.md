# Data Usage Policy — InspiraVerse

**Effective Date:** April 12, 2026

To comply with the Google Play Store Data Safety section and ensure complete transparency, InspiraVerse Labs outlines exactly how your data is collected, processed, stored, and shared.

## 1. Zero Data Sale Policy
**We do not and will never sell your personal data to any third party.** Your reflections, habits, and preferences are private and are used strictly to enhance your experience within the App.

## 2. What Data We Collect & Why

### Personal Info
- **Email Address & Display Name (Optional):** Collected only if you choose to create a cloud backup account via Firebase Authentication. Used for cross-device syncing.

### App Activity
- **Quote Interactions:** We track which quotes you "Favorite" and "Share".
  - *Purpose:* This directly influences the `popularity_score` algorithm, allowing us to surface the most impactful quotes to the community.
- **App Interactions:** Page views and feature usage (e.g., Designer Studio, Mindset Journey).
  - *Purpose:* Analyzed in aggregate via Firebase Analytics to improve app UI/UX.

### User-Generated Content
- **Journal Entries:** Your daily reflections on specific quotes.
  - *Purpose:* Stored locally on your device (`Hive`) for offline mode. If you authenticate, they are securely synced to your private Firestore document so you do not lose them when changing devices.

### Device & Diagnostics
- **Crash Logs & Performance Data:** 
  - *Purpose:* Collected anonymously to fix bugs and improve app stability.

## 3. Data Encryption & Security
All data transmitted between your device and our servers (Firebase) is encrypted in transit using industry-standard HTTPS/TLS. Data stored in Firestore is encrypted at rest by Google.

## 4. User Control & Deletion Rights
You maintain absolute control over your data:
- **Local Cache:** You can purge offline data via **Profile → Clear Local Cache**.
- **Account & Cloud Data:** You can trigger a permanent, irrecoverable deletion of all your cloud data via **Profile → Delete My Account**. Our automated backend systems (Functions) will instantly wipe your data from our active databases.

## 5. Third-Party Processing
We rely on infrastructure provided by Google (Firebase) to run securely:
- **Firebase Authentication** (Identity)
- **Cloud Firestore** (Database)
- **Firebase Analytics** (Usage data metrics)
- **Firebase Cloud Messaging** (Daily Push Notifications)

By using InspiraVerse, you consent to the processing of your data explicitly as described in this policy.
