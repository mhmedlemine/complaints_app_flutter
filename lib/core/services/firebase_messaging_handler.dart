import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

// Must be a top-level function
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, initialize Firebase.
  await Firebase.initializeApp();

  // Handle the message
  NotificationService().handleRemoteMessage(message);
}