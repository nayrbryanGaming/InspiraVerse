import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../constants/app_constants.dart';
import 'local_storage_service.dart';
import '../../widgets/permission_priming_dialog.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );
  }

  Future<void> scheduleDailyQuote() async {
    if (!LocalStorageService.isDailyNotificationEnabled) return;

    final hour = LocalStorageService.notificationHour;
    final minute = LocalStorageService.notificationMinute;

    try {
      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Clear existing to avoid overlap
      await _notificationsPlugin.cancel(0);

      // Using exact schedule mode for reliability if permission is granted
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      
      final bool? hasExactAlarmPermission = await androidImplementation?.canScheduleExactNotifications();

      await _notificationsPlugin.zonedSchedule(
        0,
        'Your Daily Inspiration ✨',
        'Tap to see your curated quote of the day.',
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.notificationChannelId,
            AppConstants.notificationChannelName,
            channelDescription: AppConstants.notificationChannelDesc,
            importance: Importance.max,
            priority: Priority.max,
            enableVibration: true,
            playSound: true,
            fullScreenIntent: true,
            category: AndroidNotificationCategory.reminder,
            styleInformation: BigTextStyleInformation(
              'Your daily mindset fuel is ready. Tap to explore the wisdom curated for your evolution today.',
              contentTitle: 'Daily Inspiration ✨',
              summaryText: 'Daily Quote'
            ),
            actions: <AndroidNotificationAction>[
              AndroidNotificationAction(
                'open',
                'Read Now 📖',
                showsUserInterface: true,
              ),
            ],
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            interruptionLevel: InterruptionLevel.active,
          ),
        ),
        androidScheduleMode: (hasExactAlarmPermission ?? false) 
            ? AndroidScheduleMode.exactAllowWhileIdle 
            : AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      debugPrint('Notification scheduling error: $e');
    }
  }

  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<bool> requestPermissions(BuildContext context) async {
    final bool? primed = await PermissionPrimingDialog.show(
      context,
      title: 'Daily Inspiration',
      description: 'We would like to send you a daily curated quote to fuel your morning mindset. This is a core part of the InspiraVerse experience.',
      icon: Icons.notifications_active_rounded,
    );

    if (primed == true) {
      // Android 13+ Permission
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      
      if (androidImplementation != null) {
        // Request notification permission
        final bool? granted = await androidImplementation.requestNotificationsPermission();
        
        // Android 12+ (API 31+) also needs exact alarm permission if used
        await androidImplementation.requestExactAlarmsPermission();
        
        return granted ?? false;
      }

      // iOS Permission
      final iosImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      if (iosImplementation != null) {
        return await iosImplementation.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: true,
        ) ?? false;
      }
      return true;
    }
    return false;
  }
}
