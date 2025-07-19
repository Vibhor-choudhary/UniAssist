import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NotificationPreferencesTab extends StatefulWidget {
  const NotificationPreferencesTab({Key? key}) : super(key: key);

  @override
  State<NotificationPreferencesTab> createState() =>
      _NotificationPreferencesTabState();
}

class _NotificationPreferencesTabState
    extends State<NotificationPreferencesTab> {
  // Notification preferences state
  bool _pushNotifications = true;
  bool _emailAlerts = true;
  bool _smsReminders = false;

  // Category preferences
  bool _academicNotifications = true;
  bool _administrativeNotifications = true;
  bool _socialNotifications = false;
  bool _attendanceAlerts = true;
  bool _assignmentReminders = true;
  bool _gradeUpdates = true;

  // Priority settings
  String _priorityThreshold = 'Medium';
  TimeOfDay _quietHoursStart = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietHoursEnd = TimeOfDay(hour: 8, minute: 0);

  // Reminder intervals
  String _assignmentReminderInterval = '1 day';
  String _attendanceReminderInterval = '2 hours';

  Future<void> _saveNotificationPreferences() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification preferences saved successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _quietHoursStart : _quietHoursEnd,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _quietHoursStart = picked;
        } else {
          _quietHoursEnd = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // General Notification Settings
          _buildSectionHeader('General Settings', 'notifications'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildSwitchTile(
                    'Push Notifications',
                    'Receive notifications on your device',
                    _pushNotifications,
                    (value) => setState(() => _pushNotifications = value),
                    'notifications_active',
                  ),
                  _buildSwitchTile(
                    'Email Alerts',
                    'Receive important updates via email',
                    _emailAlerts,
                    (value) => setState(() => _emailAlerts = value),
                    'email',
                  ),
                  _buildSwitchTile(
                    'SMS Reminders',
                    'Get text message reminders',
                    _smsReminders,
                    (value) => setState(() => _smsReminders = value),
                    'sms',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Category Preferences
          _buildSectionHeader('Notification Categories', 'category'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildSwitchTile(
                    'Academic Notifications',
                    'Class schedules, exam updates, grades',
                    _academicNotifications,
                    (value) => setState(() => _academicNotifications = value),
                    'school',
                  ),
                  _buildSwitchTile(
                    'Administrative Notifications',
                    'Fee reminders, document requests',
                    _administrativeNotifications,
                    (value) =>
                        setState(() => _administrativeNotifications = value),
                    'admin_panel_settings',
                  ),
                  _buildSwitchTile(
                    'Social Notifications',
                    'Events, clubs, campus activities',
                    _socialNotifications,
                    (value) => setState(() => _socialNotifications = value),
                    'groups',
                  ),
                  _buildSwitchTile(
                    'Attendance Alerts',
                    'Low attendance warnings',
                    _attendanceAlerts,
                    (value) => setState(() => _attendanceAlerts = value),
                    'warning',
                  ),
                  _buildSwitchTile(
                    'Assignment Reminders',
                    'Due date notifications',
                    _assignmentReminders,
                    (value) => setState(() => _assignmentReminders = value),
                    'assignment',
                  ),
                  _buildSwitchTile(
                    'Grade Updates',
                    'New grades and feedback',
                    _gradeUpdates,
                    (value) => setState(() => _gradeUpdates = value),
                    'grade',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Priority Settings
          _buildSectionHeader('Priority Settings', 'priority_high'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Priority Threshold',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Only show notifications above this priority level',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  SizedBox(height: 2.h),
                  DropdownButtonFormField<String>(
                    value: _priorityThreshold,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'priority_high',
                          size: 5.w,
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                      ),
                    ),
                    items: ['Low', 'Medium', 'High', 'Critical']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _priorityThreshold = newValue);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Quiet Hours
          _buildSectionHeader('Quiet Hours', 'bedtime'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Do Not Disturb',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Set quiet hours when you don\'t want to receive notifications',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectTime(context, true),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.lightTheme.colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Time',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  _quietHoursStart.format(context),
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectTime(context, false),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.lightTheme.colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End Time',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  _quietHoursEnd.format(context),
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
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
          ),

          SizedBox(height: 3.h),

          // Reminder Intervals
          _buildSectionHeader('Reminder Intervals', 'schedule'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildDropdownTile(
                    'Assignment Reminders',
                    'How early to remind about due dates',
                    _assignmentReminderInterval,
                    ['30 minutes', '2 hours', '1 day', '2 days', '1 week'],
                    (value) =>
                        setState(() => _assignmentReminderInterval = value!),
                    'assignment',
                  ),
                  SizedBox(height: 2.h),
                  _buildDropdownTile(
                    'Attendance Reminders',
                    'When to remind about upcoming classes',
                    _attendanceReminderInterval,
                    ['15 minutes', '30 minutes', '1 hour', '2 hours'],
                    (value) =>
                        setState(() => _attendanceReminderInterval = value!),
                    'schedule',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 4.h),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveNotificationPreferences,
              child: Text('Save Preferences'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String iconName) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: iconName,
            size: 6.w,
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
          SizedBox(width: 3.w),
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    String iconName,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: iconName,
            size: 5.w,
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  subtitle,
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
    String iconName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: iconName,
              size: 5.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        DropdownButtonFormField<String>(
          value: value,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
