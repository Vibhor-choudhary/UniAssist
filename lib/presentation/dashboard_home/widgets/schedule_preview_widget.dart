import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class SchedulePreviewWidget extends StatelessWidget {
  final VoidCallback? onViewSchedule;

  const SchedulePreviewWidget({
    Key? key,
    this.onViewSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> todaySchedule = [
      {
        "id": 1,
        "subject": "Data Structures",
        "code": "CSE201",
        "type": "Lecture",
        "startTime": DateTime.now().add(Duration(hours: 1, minutes: 30)),
        "endTime": DateTime.now().add(Duration(hours: 2, minutes: 30)),
        "room": "Room 301",
        "professor": "Dr. Sharma",
        "status": "upcoming",
      },
      {
        "id": 2,
        "subject": "Computer Networks",
        "code": "CSE301",
        "type": "Lab",
        "startTime": DateTime.now().add(Duration(hours: 3)),
        "endTime": DateTime.now().add(Duration(hours: 5)),
        "room": "Lab 205",
        "professor": "Prof. Kumar",
        "status": "upcoming",
      },
      {
        "id": 3,
        "subject": "Database Systems",
        "code": "CSE202",
        "type": "Tutorial",
        "startTime": DateTime.now().add(Duration(hours: 6)),
        "endTime": DateTime.now().add(Duration(hours: 7)),
        "room": "Room 102",
        "professor": "Dr. Patel",
        "status": "upcoming",
      },
    ];

    String formatTime(DateTime time) {
      final hour = time.hour;
      final minute = time.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    }

    String getTimeUntilNext() {
      if (todaySchedule.isEmpty) return '';

      final nextClass = todaySchedule.first;
      final startTime = (nextClass)["startTime"] as DateTime;
      final now = DateTime.now();
      final difference = startTime.difference(now);

      if (difference.inMinutes <= 0) {
        return 'Starting now';
      } else if (difference.inHours >= 1) {
        return 'in ${difference.inHours}h ${difference.inMinutes % 60}m';
      } else {
        return 'in ${difference.inMinutes}m';
      }
    }

    Color getTypeColor(String type) {
      switch (type.toLowerCase()) {
        case 'lecture':
          return AppTheme.lightTheme.primaryColor;
        case 'lab':
          return AppTheme.getSuccessColor(true);
        case 'tutorial':
          return AppTheme.getWarningColor(true);
        default:
          return AppTheme.lightTheme.colorScheme.onSurface;
      }
    }

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
                      iconName: 'schedule',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Today\'s Schedule',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (todaySchedule.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.primaryColor
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${todaySchedule.length} classes',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.lightTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            todaySchedule.isNotEmpty
                ? Column(
                    children: [
                      // Next class highlight
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.lightTheme.primaryColor
                                  .withValues(alpha: 0.1),
                              AppTheme.lightTheme.primaryColor
                                  .withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.lightTheme.primaryColor
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
                                  iconName: 'play_circle_filled',
                                  color: AppTheme.lightTheme.primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Next Class ${getTimeUntilNext()}',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (todaySchedule.first)["subject"]
                                            as String,
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '${(todaySchedule.first)["room"]} • ${(todaySchedule.first)["professor"]}',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formatTime((todaySchedule
                                          .first)["startTime"] as DateTime),
                                      style: AppTheme
                                          .lightTheme.textTheme.labelLarge
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: getTypeColor((todaySchedule
                                                .first)["type"] as String)
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        (todaySchedule.first)["type"] as String,
                                        style: AppTheme
                                            .lightTheme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: getTypeColor((todaySchedule
                                              .first)["type"] as String),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      // Remaining classes
                      Column(
                        children:
                            todaySchedule.skip(1).take(2).map((classItem) {
                          final classMap = classItem;
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.lightTheme.colorScheme.outline
                                    .withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: getTypeColor(
                                        classMap["type"] as String),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        classMap["subject"] as String,
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '${classMap["room"]} • ${classMap["type"]}',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  formatTime(classMap["startTime"] as DateTime),
                                  style: AppTheme
                                      .lightTheme.textTheme.labelMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'free_breakfast',
                          color: AppTheme.getSuccessColor(true),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'No classes scheduled for today. Enjoy your free time!',
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
                  'Updated 5 mins ago',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: onViewSchedule ??
                      () {
                        // Navigate to full schedule view
                      },
                  child: Text(
                    'Full Schedule',
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
