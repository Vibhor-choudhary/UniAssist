import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AssignmentTrackerWidget extends StatelessWidget {
  final VoidCallback? onViewAll;

  const AssignmentTrackerWidget({
    Key? key,
    this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> assignments = [
      {
        "id": 1,
        "title": "Data Structures Assignment #3",
        "subject": "CSE201",
        "dueDate": DateTime.now().add(Duration(days: 1)),
        "priority": "high",
        "status": "pending",
        "progress": 60,
        "estimatedTime": "2 hours",
        "aiScore": 95,
      },
      {
        "id": 2,
        "title": "Network Security Report",
        "subject": "CSE301",
        "dueDate": DateTime.now().add(Duration(days: 3)),
        "priority": "medium",
        "status": "in_progress",
        "progress": 30,
        "estimatedTime": "4 hours",
        "aiScore": 78,
      },
      {
        "id": 3,
        "title": "Database Design Project",
        "subject": "CSE202",
        "dueDate": DateTime.now().add(Duration(days: 7)),
        "priority": "low",
        "status": "not_started",
        "progress": 0,
        "estimatedTime": "6 hours",
        "aiScore": 65,
      },
    ];

    Color getPriorityColor(String priority) {
      switch (priority) {
        case 'high':
          return AppTheme.getErrorColor(true);
        case 'medium':
          return AppTheme.getWarningColor(true);
        case 'low':
          return AppTheme.getSuccessColor(true);
        default:
          return AppTheme.lightTheme.colorScheme.onSurface;
      }
    }

    String getStatusText(String status) {
      switch (status) {
        case 'pending':
          return 'Pending';
        case 'in_progress':
          return 'In Progress';
        case 'not_started':
          return 'Not Started';
        case 'completed':
          return 'Completed';
        default:
          return 'Unknown';
      }
    }

    String formatDueDate(DateTime dueDate) {
      final now = DateTime.now();
      final difference = dueDate.difference(now).inDays;

      if (difference == 0) {
        return 'Due Today';
      } else if (difference == 1) {
        return 'Due Tomorrow';
      } else if (difference > 1) {
        return 'Due in $difference days';
      } else {
        return 'Overdue';
      }
    }

    final urgentAssignments = (assignments as List)
        .where((assignment) =>
            (assignment as Map<String, dynamic>)["priority"] == "high" ||
            (assignment["dueDate"] as DateTime)
                    .difference(DateTime.now())
                    .inDays <=
                2)
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
                      iconName: 'assignment',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Assignments',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (urgentAssignments.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.getErrorColor(true),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${urgentAssignments.length} urgent',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              children: assignments.take(3).map((assignment) {
                final assignmentMap = assignment;
                final priority = assignmentMap["priority"] as String;
                final progress = assignmentMap["progress"] as int;
                final dueDate = assignmentMap["dueDate"] as DateTime;
                final aiScore = assignmentMap["aiScore"] as int;

                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: getPriorityColor(priority).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              assignmentMap["title"] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: getPriorityColor(priority)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              priority.toUpperCase(),
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: getPriorityColor(priority),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'schedule',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            formatDueDate(dueDate),
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                          SizedBox(width: 16),
                          CustomIconWidget(
                            iconName: 'psychology',
                            color: AppTheme.lightTheme.primaryColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'AI Score: $aiScore',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Progress',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall,
                                    ),
                                    Text(
                                      '$progress%',
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                LinearProgressIndicator(
                                  value: progress / 100,
                                  backgroundColor: AppTheme
                                      .lightTheme.colorScheme.outline
                                      .withValues(alpha: 0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    progress >= 80
                                        ? AppTheme.getSuccessColor(true)
                                        : progress >= 50
                                            ? AppTheme.getWarningColor(true)
                                            : AppTheme.getErrorColor(true),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                assignmentMap["estimatedTime"] as String,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'remaining',
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${assignments.length} active assignments',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: onViewAll ??
                      () {
                        Navigator.pushNamed(context, '/assignment-tracker');
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
