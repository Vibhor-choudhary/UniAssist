import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AttendanceOverviewCard extends StatelessWidget {
  final double attendancePercentage;
  final int totalClasses;
  final int attendedClasses;
  final int missedClasses;

  const AttendanceOverviewCard({
    Key? key,
    required this.attendancePercentage,
    required this.totalClasses,
    required this.attendedClasses,
    required this.missedClasses,
  }) : super(key: key);

  Color _getStatusColor() {
    if (attendancePercentage >= 75) {
      return AppTheme.getSuccessColor(true);
    } else if (attendancePercentage >= 65) {
      return AppTheme.getWarningColor(true);
    } else {
      return AppTheme.getErrorColor(true);
    }
  }

  String _getStatusText() {
    if (attendancePercentage >= 75) {
      return "Excellent";
    } else if (attendancePercentage >= 65) {
      return "Warning";
    } else {
      return "Critical";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Overall Attendance",
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        _getStatusText(),
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Classes",
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                Text(
                                  totalClasses.toString(),
                                  style:
                                      AppTheme.lightTheme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attended",
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                Text(
                                  attendedClasses.toString(),
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.getSuccessColor(true),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Missed",
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                Text(
                                  missedClasses.toString(),
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.getErrorColor(true),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: Stack(
                        children: [
                          CircularProgressIndicator(
                            value: attendancePercentage / 100,
                            strokeWidth: 8,
                            backgroundColor:
                                _getStatusColor().withValues(alpha: 0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                                _getStatusColor()),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${attendancePercentage.toStringAsFixed(1)}%",
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
