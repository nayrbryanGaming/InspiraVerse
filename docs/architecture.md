# InspiraVerse System Architecture

InspiraVerse is built on a high-resilience, serverless architecture optimized for scalability, offline performance, and compliance.

## 🏗 High-Level Architecture

```mermaid
graph TD
    subgraph "Mobile Ecosystem (Flutter)"
        App[InspiraVerse App]
        Hive[(Local Storage - Hive)]
        Auth[Firebase Auth]
    end

    subgraph "Serverless Backend (Firebase)"
        Functions[Cloud Functions Node.js]
        Firestore[(Cloud Firestore NoSQL)]
        FCM[Cloud Messaging]
        Storage[Firebase Storage]
    end

    subgraph "Web Presence (Vercel)"
        Landing[Next.js Landing Page]
    end

    App <--> Hive
    App <--> Auth
    App <--> Firestore
    App <--> Storage
    App <--> Functions
    Functions <--> Firestore
    Functions --> FCM
```

## 🔐 Compliance Layer (Account Deletion)

```mermaid
sequenceDiagram
    participant User
    participant App
    participant Auth as Firebase Auth
    participant Functions as Cloud Functions
    participant FS as Firestore

    User->>App: Clicks "Delete Account"
    App->>User: Confirmation Dialog (5s Countdown)
    User->>App: Types 'DELETE'
    App->>Auth: Request account deletion
    Auth->>Functions: Trigger onUserDeleted
    Functions->>FS: Delete user_activity doc
    Functions->>FS: Delete profile doc
    Functions->>App: Return Success
```

## 📉 Content Pipeline

```mermaid
graph LR
    Curator[Curated Datasets] --> Functions
    Functions --> Firestore
    Firestore --> App
    App --> Designer[Designer Studio]
    Designer --> Social[Instagram/TikTok Share]
```
