import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification service
  static Future<void> initialize() async {
    print('🔔 Initializing notification service...');

    // Request permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print('📱 Permission status: ${settings.authorizationStatus}');

    // Initialize local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Subscribe to topic for receiving notifications from Firebase Console
    await _firebaseMessaging.subscribeToTopic('student_updates');
    print('📺 Subscribed to student_updates topic');

    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    print('📱 FCM Token: $token');

    // Handle foreground messages (when app is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📨 Received foreground message: ${message.notification?.title}');
      _showLocalNotification(
        title: message.notification?.title ?? 'New Notification',
        body: message.notification?.body ?? '',
        data: message.data,
      );
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('👆 Notification tapped from background: ${message.data}');
      _handleNotificationTap(message.data);
    });

    // Handle initial message when app is opened from terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('🚀 App opened from notification: ${initialMessage.data}');
      _handleNotificationTap(initialMessage.data);
    }

    print('✅ Notification service initialized successfully!');
  }























  /// Handle notification tap
  static void _onNotificationTapped(NotificationResponse response) {
    print('👆 Local notification tapped');
    // Navigate to students view when notification is tapped
    if (Get.currentRoute != '/view-students') {
      Get.toNamed('/view-students');
    }
  }

  /// Handle background notification tap
  static void _handleNotificationTap(Map<String, dynamic> data) {
    print('📱 Handling notification tap with data: $data');

    // Navigate based on notification type
    if (data['type'] == 'student_added' || data['action'] == 'view_students') {
      if (Get.currentRoute != '/view-students') {
        Get.toNamed('/view-students');
      }
    }
  }

  /// Show local notification
  static Future<void> _showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'student_channel',
          'Student Notifications',
          channelDescription: 'Notifications for student operations',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
          icon: '@mipmap/ic_launcher',
          color: Color(0xFF2196F3),
          playSound: true,
          enableVibration: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      notificationDetails,
      payload: data?.toString(),
    );
  }

  /// Show notification when student is added
  static Future<void> showStudentAddedNotification({
    required String studentName,
    required String rollNumber,
  }) async {
    // Show immediate local notification
    await _showLocalNotification(
      title: '✅ Student Added Successfully!',
      body: '$studentName (Roll: $rollNumber) has been added to the system.',
      data: {
        'type': 'student_added',
        'student_name': studentName,
        'roll_number': rollNumber,
      },
    );

    print('🎉 Local notification sent for student: $studentName');

    // Log instructions for manual Firebase Console notification
    print('📋 To notify other users:');
    print('   1. Go to Firebase Console → Messaging');
    print('   2. Create notification with topic: student_updates');
    print('   3. Title: "👨‍🎓 New Student Added"');
    print('   4. Body: "$studentName (Roll: $rollNumber) has been added!"');
  }

  /// Get FCM token for debugging
  static Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Subscribe to additional topics if needed
  static Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    print('📺 Subscribed to $topic topic');
  }

  /// Unsubscribe from topics if needed
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print('📺 Unsubscribed from $topic topic');
  }
}

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('📨 Background message received: ${message.notification?.title}');
}
