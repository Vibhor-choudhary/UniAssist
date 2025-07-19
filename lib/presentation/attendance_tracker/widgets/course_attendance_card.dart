import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseAttendanceCard extends StatefulWidget {
  final Map<String, dynamic> courseData;
  final VoidCallback? onTap;

  const CourseAttendanceCard({
    Key? key,
    required this.courseData,
    this.onTap,
  }) : super(key: key);

  @override
  State<CourseAttendanceCard> createState() => _CourseAttendanceCardState();
}

class _CourseAttendanceCardState extends State<CourseAttendanceCard> {
  bool _isExpanded = false;

  Color _getStatusColor(double percentage) {
    if (percentage >= 75) {
      return AppTheme.getSuccessColor(true);
    } else if (percentage >= 65) {
      return AppTheme.getWarningColor(true);
    } else {
      return AppTheme.getErrorColor(true);
    }
  }

  Widget _buildTrendIcon(String trend) {
    IconData iconData;
    Color iconColor;

    switch (trend.toLowerCase()) {
      case 'up':
        iconData = Icons.trending_up;
        iconColor = AppTheme.getSuccessColor(true);
        break;
      case 'down':
        iconData = Icons.trending_down;
        iconColor = AppTheme.getErrorColor(true);
        break;
      default:
        iconData = Icons.trending_flat;
        iconColor = AppTheme.getWarningColor(true);
    }

    return CustomIconWidget(
      iconName: iconData == Icons.trending_up
          ? 'trending_up'
          : iconData == Icons.trending_down
              ? 'trending_down'
              : 'trending_flat',
      color: iconColor,
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseCode = widget.courseData['courseCode'] as String;
    final courseName = widget.courseData['courseName'] as String;
    final percentage = (widget.courseData['percentage'] as num).toDouble();
    final attended = widget.courseData['attended'] as int;
    final total = widget.courseData['total'] as int;
    final trend = widget.courseData['trend'] as String;
    final attendanceRecords =
        widget.courseData['records'] as List<Map<String, dynamic>>;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
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
                          courseCode,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          courseName,
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${percentage.toStringAsFixed(1)}%",
                            style: AppTheme.lightTheme.textTheme.titleLarge
                                ?.copyWith(
                              color: _getStatusColor(percentage),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          _buildTrendIcon(trend),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "$attended/$total classes",
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor:
                    _getStatusColor(percentage).withValues(alpha: 0.2),
                valueColor:
                    AlwaysStoppedAnimation<Color>(_getStatusColor(percentage)),
                minHeight: 6,
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tap to view details",
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  CustomIconWidget(
                    iconName: _isExpanded ? 'expand_less' : 'expand_more',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 2.h),
                Divider(),
                SizedBox(height: 1.h),
                Text(
                  "Recent Attendance Records",
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.h),
                ...attendanceRecords.take(5).map((record) {
                  final date = record['date'] as String;
                  final status = record['status'] as String;
                  final topic = record['topic'] as String;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: status == 'Present'
                                ? AppTheme.getSuccessColor(true)
                                : AppTheme.getErrorColor(true),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                topic,
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: status == 'Present'
                                ? AppTheme.getSuccessColor(true)
                                    .withValues(alpha: 0.1)
                                : AppTheme.getErrorColor(true)
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: status == 'Present'
                                  ? AppTheme.getSuccessColor(true)
                                  : AppTheme.getErrorColor(true),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
