import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/assignment_tracker_widget.dart';
import './widgets/attendance_overview_widget.dart';
import './widgets/notification_summary_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/schedule_preview_widget.dart';
import './widgets/voice_ai_button_widget.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate data refresh
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _showUserProfile() {
    Navigator.pushNamed(context, '/user-profile-settings');
  }

  void _showNotifications() {
    Navigator.pushNamed(context, '/smart-notifications-center');
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Search Campus Services',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for classes, assignments, services...',
                prefixIcon: CustomIconWidget(
                  iconName: 'search',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Attendance',
                'Assignments',
                'Grades',
                'Schedule',
                'Fees',
                'Library'
              ]
                  .map((tag) => Chip(
                        label: Text(
                          tag,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                        onDeleted: () {},
                        deleteIcon: CustomIconWidget(
                          iconName: 'add',
                          size: 16,
                          color: AppTheme.lightTheme.primaryColor,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'LPU',
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Campus Copilot',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.primaryColor,
              ),
            ),
            Text(
              'Welcome back, Rajesh!',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showSearchDialog,
            icon: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: _showNotifications,
                icon: CustomIconWidget(
                  iconName: 'notifications',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.getErrorColor(true),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _showUserProfile,
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'person',
                color: AppTheme.lightTheme.primaryColor,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            color: AppTheme.lightTheme.primaryColor,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message with current time
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.lightTheme.primaryColor
                              .withValues(alpha: 0.1),
                          AppTheme.lightTheme.colorScheme.secondary
                              .withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good ${_getTimeOfDayGreeting()}!',
                                style: AppTheme
                                    .lightTheme.textTheme.headlineSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.lightTheme.primaryColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Ready to conquer your academic goals today?',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CustomIconWidget(
                          iconName: 'school',
                          color: AppTheme.lightTheme.primaryColor
                              .withValues(alpha: 0.3),
                          size: 48,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Priority widgets section
                  Text(
                    'Priority Updates',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Notification Summary Widget
                  NotificationSummaryWidget(
                    onViewAll: () => Navigator.pushNamed(
                        context, '/smart-notifications-center'),
                  ),
                  SizedBox(height: 16),

                  // Attendance Overview Widget
                  AttendanceOverviewWidget(
                    onViewDetails: () =>
                        Navigator.pushNamed(context, '/attendance-tracker'),
                  ),
                  SizedBox(height: 24),

                  // Academic section
                  Text(
                    'Academic Overview',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Assignment Tracker Widget
                  AssignmentTrackerWidget(
                    onViewAll: () =>
                        Navigator.pushNamed(context, '/assignment-tracker'),
                  ),
                  SizedBox(height: 16),

                  // Schedule Preview Widget
                  SchedulePreviewWidget(
                    onViewSchedule: () {
                      // Navigate to full schedule
                    },
                  ),
                  SizedBox(height: 24),

                  // Quick Actions section
                  Text(
                    'Quick Access',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Quick Actions Widget
                  QuickActionsWidget(),
                  SizedBox(height: 24),

                  // Footer with app info
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'psychology',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Powered by Campus Copilot AI',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100), // Extra space for floating button
                ],
              ),
            ),
          ),

          // Voice AI Button
          VoiceAiButtonWidget(),

          // Loading overlay
          if (_isRefreshing)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppTheme.lightTheme.primaryColor,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Updating your dashboard...',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getTimeOfDayGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }
}
