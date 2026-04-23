# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase Auth
-keep class com.google.firebase.auth.** { *; }
-keep class com.google.android.gms.internal.firebase-auth-api.** { *; }

# Firebase Firestore
-keep class com.google.firebase.firestore.** { *; }

# Firebase Functions
-keep class com.google.firebase.functions.** { *; }

# Firebase Messaging / Cloud Messaging
-keep class com.google.firebase.messaging.** { *; }

# Firebase Analytics
-keep class com.google.android.gms.measurement.** { *; }
-keep class com.google.firebase.analytics.** { *; }

# Google Fonts
-keep class com.google.fonts.** { *; }

# Hive
-keep class com.hivedb.** { *; }
-keep class io.hive.** { *; }
-keep class * extends io.hive.HiveObject { *; }

# Riverpod
-keep class com.riverpod.** { *; }

# Lottie
-keep class com.airbnb.lottie.** { *; }

# Standard Android
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn com.google.android.gms.**
-dontwarn com.google.firebase.**
