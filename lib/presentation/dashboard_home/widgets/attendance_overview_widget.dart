import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AttendanceOverviewWidget extends StatelessWidget {
  final VoidCallback? onViewDetails;

  const AttendanceOverviewWidget({
    Key? key,
    this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> subjects = [
      {
        "name": "Data Structures",
        "code": "CSE201",
        "attendance": 85.5,
        "totalClasses": 40,
        "attendedClasses": 34,
        "status": "good"
      },
      {
        "name": "Computer Networks",
        "code": "CSE301",
        "attendance": 72.0,
        "totalClasses": 35,
        "attendedClasses": 25,
        "status": "warning"
      },
      {
        "name": "Database Systems",
        "code": "CSE202",
        "attendance": 68.5,
        "totalClasses": 38,
        "attendedClasses": 26,
        "status": "critical"
      },
    ];

    double overallAttendance = (subjects as List).fold(
            0.0,
            (sum, subject) =>
                sum +
                ((subject as Map<String, dynamic>)["attendance"] as double)) /
        subjects.length;

    Color getStatusColor(String status) {
      switch (status) {
        case 'good':
          return AppTheme.getSuccessColor(true);
        case 'warning':
          return AppTheme.getWarningColor(true);
        case 'critical':
          return AppTheme.getErrorColor(true);
        default:
          return AppTheme.lightTheme.colorScheme.onSurface;
      }
    }

    String getStatusText(String status) {
      switch (status) {
        case 'good':
          return 'Good';
        case 'warning':
          return 'Below Threshold';
        case 'critical':
          return 'Critical';
        default:
          return 'Unknown';
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
                      iconName: 'school',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Attendance Overview',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: overallAttendance >= 75
                        ? AppTheme.getSuccessColor(true).withValues(alpha: 0.1)
                        : AppTheme.getWarningColor(true).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${overallAttendance.toStringAsFixed(1)}%',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: overallAttendance >= 75
                          ? AppTheme.getSuccessColor(true)
                          : AppTheme.getWarningColor(true),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overall Attendance',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${overallAttendance.toStringAsFixed(1)}%',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: overallAttendance >= 75
                                ? AppTheme.getSuccessColor(true)
                                : AppTheme.getWarningColor(true),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: Stack(
                      children: [
                        CircularProgressIndicator(
                          value: overallAttendance / 100,
                          strokeWidth: 6,
                          backgroundColor: AppTheme
                              .lightTheme.colorScheme.outline
                              .withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            overallAttendance >= 75
                                ? AppTheme.getSuccessColor(true)
                                : AppTheme.getWarningColor(true),
                          ),
                        ),
                        Center(
                          child: CustomIconWidget(
                            iconName: overallAttendance >= 75
                                ? 'trending_up'
                                : 'trending_down',
                            color: overallAttendance >= 75
                                ? AppTheme.getSuccessColor(true)
                                : AppTheme.getWarningColor(true),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Subject Breakdown',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: subjects.take(3).map((subject) {
                final subjectMap = subject;
                final attendance = subjectMap["attendance"] as double;
                final status = subjectMap["status"] as String;

                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: getStatusColor(status).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subjectMap["name"] as String,
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${subjectMap["attendedClasses"]}/${subjectMap["totalClasses"]} classes',
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${attendance.toStringAsFixed(1)}%',
                            style: AppTheme.lightTheme.textTheme.labelLarge
                                ?.copyWith(
                              color: getStatusColor(status),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            getStatusText(status),
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: getStatusColor(status),
                            ),
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
                  'Last updated: Just now',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                TextButton(
                  onPressed: onViewDetails ??
                      () {
                        Navigator.pushNamed(context, '/attendance-tracker');
                      },
                  child: Text(
                    'View Details',
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
