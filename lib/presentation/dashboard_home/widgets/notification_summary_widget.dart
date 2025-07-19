import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class NotificationSummaryWidget extends StatelessWidget {
  final VoidCallback? onViewAll;

  const NotificationSummaryWidget({
    Key? key,
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "id": 1,
        "title": "Assignment Due Tomorrow",
        "message": "Data Structures Assignment #3 is due by 11:59 PM",
        "type": "academic",
        "priority": "urgent",
        "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
        "isRead": false,
      },
      {
        "id": 2,
        "title": "Attendance Alert",
        "message":
            "Your attendance in Computer Networks is 72% - Below threshold",
        "type": "academic",
        "priority": "high",
        "timestamp": DateTime.now().subtract(Duration(hours: 2)),
        "isRead": false,
      },
      {
        "id": 3,
        "title": "Fee Payment Reminder",
        "message": "Semester fee payment due in 3 days",
        "type": "administrative",
        "priority": "medium",
        "timestamp": DateTime.now().subtract(Duration(hours: 4)),
        "isRead": true,
      },
    ];

    final urgentNotifications = (notifications as List)
        .where((notification) =>
            (notification as Map<String, dynamic>)["priority"] == "urgent" &&
            !(notification["isRead"] as bool))
        .toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'notifications',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Smart Notifications',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (urgentNotifications.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${urgentNotifications.length}',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            urgentNotifications.isNotEmpty
                ? Column(
                    children: urgentNotifications.take(2).map((notification) {
                      final notificationMap =
                          notification as Map<String, dynamic>;
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.error
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.error
                                .withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'priority_high',
                                  color: AppTheme.lightTheme.colorScheme.error,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    notificationMap["title"] as String,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelLarge
                                        ?.copyWith(
                                      color:
                                          AppTheme.lightTheme.colorScheme.error,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              notificationMap["message"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          AppTheme.getSuccessColor(true).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'check_circle',
                          color: AppTheme.getSuccessColor(true),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'All caught up! No urgent notifications.',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.getSuccessColor(true),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${notifications.length} total notifications',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: onViewAll ??
                      () {
                        Navigator.pushNamed(
                            context, '/smart-notifications-center');
                      },
                  child: Text(
                    'View All',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
