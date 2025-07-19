import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import './assignment_card_widget.dart';

class AssignmentListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> assignments;
  final String sortBy;
  final Function(Map<String, dynamic>) onAssignmentTap;
  final Function(Map<String, dynamic>) onStatusUpdate;

  const AssignmentListWidget({
    Key? key,
    required this.assignments,
    required this.sortBy,
    required this.onAssignmentTap,
    required this.onStatusUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (assignments.isEmpty) {
      return _buildEmptyState(context);
    }

    final sortedAssignments = _sortAssignments(assignments, sortBy);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedAssignments.length,
      itemBuilder: (context, index) {
        final assignment = sortedAssignments[index];
        return AssignmentCardWidget(
          assignment: assignment,
          onTap: () => onAssignmentTap(assignment),
          onStatusUpdate: () => onStatusUpdate(assignment),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'assignment',
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant
                .withValues(alpha: 0.5),
            size: 64,
          ),
          SizedBox(height: 3.h),
          Text(
            'No assignments found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your filters or check back later for new assignments.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _sortAssignments(
    List<Map<String, dynamic>> assignments,
    String sortBy,
  ) {
    final List<Map<String, dynamic>> sortedList = List.from(assignments);

    switch (sortBy) {
      case 'Due Date':
        sortedList.sort((a, b) {
          final dateA = a['dueDate'] as DateTime? ?? DateTime.now();
          final dateB = b['dueDate'] as DateTime? ?? DateTime.now();
          return dateA.compareTo(dateB);
        });
        break;
      case 'Priority':
        sortedList.sort((a, b) {
          final priorityA = a['priority'] as int? ?? 1;
          final priorityB = b['priority'] as int? ?? 1;
          return priorityB.compareTo(priorityA); // High priority first
        });
        break;
      case 'Course':
        sortedList.sort((a, b) {
          final courseA = a['courseName'] as String? ?? '';
          final courseB = b['courseName'] as String? ?? '';
          return courseA.compareTo(courseB);
        });
        break;
      case 'Progress':
        sortedList.sort((a, b) {
          final progressA = (a['progress'] as num?)?.toDouble() ?? 0.0;
          final progressB = (b['progress'] as num?)?.toDouble() ?? 0.0;
          return progressA.compareTo(progressB);
        });
        break;
      default:
        // Default sort by due date
        sortedList.sort((a, b) {
          final dateA = a['dueDate'] as DateTime? ?? DateTime.now();
          final dateB = b['dueDate'] as DateTime? ?? DateTime.now();
          return dateA.compareTo(dateB);
        });
        break;
    }

    return sortedList;
  }
}
