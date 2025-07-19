import 'package:flutter/material.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/assignment_tracker/assignment_tracker.dart';
import '../presentation/dashboard_home/dashboard_home.dart';
import '../presentation/user_profile_settings/user_profile_settings.dart';
import '../presentation/smart_notifications_center/smart_notifications_center.dart';
import '../presentation/attendance_tracker/attendance_tracker.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String loginScreen = '/login-screen';
  static const String assignmentTracker = '/assignment-tracker';
  static const String dashboardHome = '/dashboard-home';
  static const String userProfileSettings = '/user-profile-settings';
  static const String smartNotificationsCenter = '/smart-notifications-center';
  static const String attendanceTracker = '/attendance-tracker';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const DashboardHome(),
    loginScreen: (context) => const LoginScreen(),
    assignmentTracker: (context) => const AssignmentTracker(),
    dashboardHome: (context) => const DashboardHome(),
    userProfileSettings: (context) => const UserProfileSettings(),
    smartNotificationsCenter: (context) => const SmartNotificationsCenter(),
    attendanceTracker: (context) => const AttendanceTracker(),
    // TODO: Add your other routes here
  };
}
