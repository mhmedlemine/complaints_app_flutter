import 'package:complaintsapp/core/services/firebase_messaging_handler.dart';
// import 'package:complaintsapp/core/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get_it/get_it.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // final NavigationService _navigationService = GetIt.instance<NavigationService>();

  Future<void> initialize() async {
    // Request permissions for iOS
    await _requestPermission();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen(_onMessageHandler);

    // Listen to messages when the app is opened from a terminated state
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedAppHandler);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission for notifications');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission for notifications');
    } else {
      debugPrint('User declined or has not accepted permission for notifications');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    );
  }

  void _onMessageHandler(RemoteMessage message) {
    debugPrint('Received a foreground message: ${message.messageId}');
    if (message.notification != null) {
      _showLocalNotification(message);
    }
  }

  void _onMessageOpenedAppHandler(RemoteMessage message) {
    debugPrint('Message clicked!: ${message.messageId}');
    // Navigate to a specific screen based on the message
    // Example:
    // NavigationService.navigatorKey.currentState?.pushNamed('/detail');
  }

  void handleRemoteMessage(RemoteMessage message) {
    debugPrint('Handling a background message: ${message.messageId}');
    if (message.notification != null) {
      _showLocalNotification(message);
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'No Title',
      message.notification?.body ?? 'No Body',
      platformChannelSpecifics,
      payload: message.data['payload'] ?? '',
    );
  }

  Future<void> _onSelectNotification(String? payload) async {
    debugPrint('Notification clicked with payload: $payload');
    if (payload != null && payload.isNotEmpty) {
      // _navigationService.navigateTo('/', arguments: payload);
    }
  }

  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Optionally, you can subscribe/unsubscribe to topics
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
}

void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
}