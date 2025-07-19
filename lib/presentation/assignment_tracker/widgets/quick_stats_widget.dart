import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickStatsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> assignments;

  const QuickStatsWidget({
    Key? key,
    required this.assignments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              context,
              'Total',
              stats['total'].toString(),
              'assignment',
              Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: _buildStatCard(
              context,
              'Pending',
              stats['pending'].toString(),
              'pending_actions',
              Theme.of(context).colorScheme.tertiary,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: _buildStatCard(
              context,
              'Overdue',
              stats['overdue'].toString(),
              'error',
              Theme.of(context).colorScheme.error,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: _buildStatCard(
              context,
              'Completed',
              stats['completed'].toString(),
              'check_circle',
              AppTheme.getSuccessColor(
                  Theme.of(context).brightness == Brightness.light),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    String iconName,
    Color color,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 24,
            ),
            SizedBox(height: 1.h),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Map<String, int> _calculateStats() {
    final now = DateTime.now();
    int total = assignments.length;
    int pending = 0;
    int overdue = 0;
    int completed = 0;

    for (final assignment in assignments) {
      final status =
          (assignment['status'] as String? ?? 'pending').toLowerCase();
      final dueDate = assignment['dueDate'] as DateTime? ?? DateTime.now();

      switch (status) {
        case 'completed':
          completed++;
          break;
        case 'overdue':
          overdue++;
          break;
        default:
          if (dueDate.isBefore(now) && status != 'completed') {
            overdue++;
          } else {
            pending++;
          }
          break;
      }
    }

    return {
      'total': total,
      'pending': pending,
      'overdue': overdue,
      'completed': completed,
    };
  }
}
