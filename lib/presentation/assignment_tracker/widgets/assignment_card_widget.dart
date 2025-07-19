import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AssignmentCardWidget extends StatelessWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback? onTap;
  final VoidCallback? onStatusUpdate;

  const AssignmentCardWidget({
    Key? key,
    required this.assignment,
    this.onTap,
    this.onStatusUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String status = assignment['status'] as String? ?? 'pending';
    final int priority = assignment['priority'] as int? ?? 1;
    final DateTime dueDate =
        assignment['dueDate'] as DateTime? ?? DateTime.now();
    final double progress = (assignment['progress'] as num?)?.toDouble() ?? 0.0;
    final int estimatedHours = assignment['estimatedHours'] as int? ?? 1;

    final Color priorityColor = _getPriorityColor(priority, isDarkMode);
    final Color statusColor = _getStatusColor(status, isDarkMode);
    final String timeRemaining = _getTimeRemaining(dueDate);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assignment['courseName'] as String? ??
                                'Unknown Course',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            assignment['title'] as String? ??
                                'Untitled Assignment',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: priorityColor, width: 1),
                      ),
                      child: Text(
                        _getPriorityText(priority),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: priorityColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'schedule',
                      color: statusColor,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      timeRemaining,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Spacer(),
                    CustomIconWidget(
                      iconName: 'access_time',
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${estimatedHours}h',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          '${(progress * 100).toInt()}%',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      minHeight: 6,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: _getStatusIcon(status),
                              color: statusColor,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              _getStatusText(status),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    InkWell(
                      onTap: onStatusUpdate,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.all(1.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: 'more_vert',
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority, bool isDarkMode) {
    switch (priority) {
      case 3:
        return isDarkMode ? AppTheme.errorDark : AppTheme.errorLight;
      case 2:
        return isDarkMode ? AppTheme.warningDark : AppTheme.warningLight;
      default:
        return isDarkMode ? AppTheme.successDark : AppTheme.successLight;
    }
  }

  String _getPriorityText(int priority) {
    switch (priority) {
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      default:
        return 'Low';
    }
  }

  Color _getStatusColor(String status, bool isDarkMode) {
    switch (status.toLowerCase()) {
      case 'completed':
        return isDarkMode ? AppTheme.successDark : AppTheme.successLight;
      case 'in-progress':
        return isDarkMode ? AppTheme.warningDark : AppTheme.warningLight;
      case 'overdue':
        return isDarkMode ? AppTheme.errorDark : AppTheme.errorLight;
      default:
        return isDarkMode
            ? AppTheme.textSecondaryDark
            : AppTheme.textSecondaryLight;
    }
  }

  String _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'check_circle';
      case 'in-progress':
        return 'pending';
      case 'overdue':
        return 'error';
      default:
        return 'radio_button_unchecked';
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'in-progress':
        return 'In Progress';
      case 'overdue':
        return 'Overdue';
      default:
        return 'Pending';
    }
  }

  String _getTimeRemaining(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now);

    if (difference.isNegative) {
      final overdue = now.difference(dueDate);
      if (overdue.inDays > 0) {
        return 'Overdue by ${overdue.inDays} day${overdue.inDays > 1 ? 's' : ''}';
      } else if (overdue.inHours > 0) {
        return 'Overdue by ${overdue.inHours} hour${overdue.inHours > 1 ? 's' : ''}';
      } else {
        return 'Overdue by ${overdue.inMinutes} min';
      }
    }

    if (difference.inDays > 0) {
      return 'Due in ${difference.inDays} day${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Due in ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}';
    } else {
      return 'Due in ${difference.inMinutes} min';
    }
  }
}
