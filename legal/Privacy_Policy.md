# Privacy Policy — InspiraVerse

**Effective Date:** April 12, 2026
**Last Updated:** April 12, 2026

InspiraVerse ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your personal information when you use the InspiraVerse mobile application ("App") and our website.

---

## 1. Information We Collect

### 1.1 Information You Provide
- **Account Information:** Email address and display name when you register.
- **Content You Create:** Personal journal reflections and quotes you author within the App.

### 1.2 Information Collected Automatically
- **Device Information:** Device type, operating system version, and unique device identifiers.
- **Usage Data:** Quote views, favorites, shares, and streak activity, collected to improve your experience.
- **Crash Reports:** Anonymous diagnostic data to identify and fix technical issues.

### 1.3 Firebase & Analytics
We use **Firebase Analytics** to understand aggregate usage patterns. This data is anonymized and is **not** linked to your personal identity.

---

## 2. How We Use Your Information

We use the information we collect to:

- Provide, maintain, and improve the InspiraVerse App.
- Personalize your daily quote feed based on your selected preferences.
- Send daily motivational push notifications via **Firebase Cloud Messaging (FCM)**, which you may disable at any time in your device settings.
- Analyze aggregate usage trends to improve content curation.
- Respond to your support requests.

---

## 3. Data Sharing

We **do not sell, trade, or rent** your personal information to third parties.

We may share anonymized, aggregated data with:
- **Firebase (Google LLC):** For database hosting, authentication, and analytics. [Google Privacy Policy](https://policies.google.com/privacy).

We may disclose your information if required by law or to protect the rights and safety of our users.

---

## 4. Push Notifications (FCM)

We use Firebase Cloud Messaging to send you daily inspirational quote notifications. You can opt out at any time by:
1. Going to **Profile → Settings** in the App.
2. Disabling "Daily Notification" toggle.
3. Or via your device's **System Settings → Notifications → InspiraVerse**.

---

## 5. Data Transparency & Storage Centers

### 5.1 Local Storage (Resilience)
We use **Hive** (local device storage) to cache quotes and store your Journal Entries for offline use. This data remains on your physical device and is not accessible to us unless synced to our cloud servers.

### 5.2 Cloud Storage (Sync)
If you authenticate, your preferences and journal entries are securely synced to **Cloud Firestore**. This ensures you do not lose your developmental journey when changing devices.

---

## 6. Retention & Permanent Deletion

### 6.1 Retention Period
We retain your data for as long as your account is active. 

### 6.2 Data Deletion Rights (Play Store Compliance)
You maintain absolute control over your data. You may initiate a deletion request via **Profile → Settings → Delete My Account**.
- **Immediate Revocation**: Your authentication token is revoked immediately.
- **Server-Side Purge**: A Firebase Cloud Function trigger is initiated to permanently and irrecoverably wipe all associated Firestore documents (activity, profile, journals) and storage assets.
- **Local Purge**: The App will automatically clear all local Hive boxes on the device upon sign-out/deletion.

This action is **PERMANENT**. Once your data is deleted, it cannot be recovered by InspiraVerse support.

---

## 7. Children's Privacy

InspiraVerse is not directed to children under the age of 13. We do not knowingly collect personal information from children under 13. If we discover such data has been collected, we will delete it immediately.

---

## 8. Security

We implement industry-standard security measures including Firebase Authentication, Firestore Security Rules, and HTTPS encryption for all data in transit.

---

## 9. Changes to This Policy

We may update this Privacy Policy periodically. We will notify you of any significant changes by updating the "Last Updated" date at the top of this document. Continued use of the App after changes constitutes your acceptance.

---

## 10. Contact Us

If you have questions about this Privacy Policy, please contact us:

**Email:** support@inspiraverse.app
**Website:** https://inspiraverse.app/legal/privacy
