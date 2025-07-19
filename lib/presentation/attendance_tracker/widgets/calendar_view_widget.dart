import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CalendarViewWidget extends StatefulWidget {
  final List<Map<String, dynamic>> attendanceData;

  const CalendarViewWidget({
    Key? key,
    required this.attendanceData,
  }) : super(key: key);

  @override
  State<CalendarViewWidget> createState() => _CalendarViewWidgetState();
}

class _CalendarViewWidgetState extends State<CalendarViewWidget> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Calendar View",
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _previousMonth,
                      icon: CustomIconWidget(
                        iconName: 'chevron_left',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    Text(
                      _getMonthYearString(_focusedDate),
                      style: AppTheme.lightTheme.textTheme.titleSmall,
                    ),
                    IconButton(
                      onPressed: _nextMonth,
                      icon: CustomIconWidget(
                        iconName: 'chevron_right',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildCalendarGrid(),
            SizedBox(height: 2.h),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    return Column(
      children: [
        // Weekday headers
        Row(
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 1.h),
        // Calendar days
        ...List.generate(6, (weekIndex) {
          return Row(
            children: List.generate(7, (dayIndex) {
              final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 2;

              if (dayNumber <= 0 || dayNumber > daysInMonth) {
                return Expanded(child: SizedBox(height: 6.h));
              }

              final currentDate =
                  DateTime(_focusedDate.year, _focusedDate.month, dayNumber);
              final attendanceStatus = _getAttendanceStatus(currentDate);

              return Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(currentDate),
                  child: Container(
                    height: 6.h,
                    margin: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: _getDateBackgroundColor(
                          currentDate, attendanceStatus),
                      borderRadius: BorderRadius.circular(4),
                      border: _selectedDate.day == dayNumber &&
                              _selectedDate.month == _focusedDate.month &&
                              _selectedDate.year == _focusedDate.year
                          ? Border.all(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        dayNumber.toString(),
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              _getDateTextColor(currentDate, attendanceStatus),
                          fontWeight: _selectedDate.day == dayNumber &&
                                  _selectedDate.month == _focusedDate.month &&
                                  _selectedDate.year == _focusedDate.year
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }).where((row) {
          // Only show rows that have at least one valid day
          return true;
        }).toList(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem(
          "Present",
          AppTheme.getSuccessColor(true),
        ),
        _buildLegendItem(
          "Absent",
          AppTheme.getErrorColor(true),
        ),
        _buildLegendItem(
          "Upcoming",
          AppTheme.lightTheme.colorScheme.primary,
        ),
        _buildLegendItem(
          "No Class",
          Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
      ],
    );
  }

  String _getAttendanceStatus(DateTime date) {
    final dateString =
        "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";

    // Check if there's any attendance record for this date
    for (final courseData in widget.attendanceData) {
      final records = courseData['records'] as List<Map<String, dynamic>>;
      for (final record in records) {
        if (record['date'] == dateString) {
          return record['status'] as String;
        }
      }
    }

    // Check if it's a future date
    if (date.isAfter(DateTime.now())) {
      // Assume classes on weekdays only
      if (date.weekday >= 1 && date.weekday <= 5) {
        return 'Upcoming';
      }
    }

    return 'No Class';
  }

  Color _getDateBackgroundColor(DateTime date, String status) {
    switch (status) {
      case 'Present':
        return AppTheme.getSuccessColor(true).withValues(alpha: 0.2);
      case 'Absent':
        return AppTheme.getErrorColor(true).withValues(alpha: 0.2);
      case 'Upcoming':
        return AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.2);
      default:
        return Colors.transparent;
    }
  }

  Color _getDateTextColor(DateTime date, String status) {
    switch (status) {
      case 'Present':
        return AppTheme.getSuccessColor(true);
      case 'Absent':
        return AppTheme.getErrorColor(true);
      case 'Upcoming':
        return AppTheme.lightTheme.colorScheme.primary;
      default:
        return AppTheme.lightTheme.textTheme.bodyMedium?.color ?? Colors.black;
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _previousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1);
    });
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return "${months[date.month - 1]} ${date.year}";
  }
}
