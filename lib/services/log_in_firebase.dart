import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class ServiceLog {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> sendAnalyticsEvent(
      String eventName, Map<String, dynamic> parameters) async {
    await analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
    if (kDebugMode) {
      print('Analytics Event Sent: $eventName');
    }
  }
}
