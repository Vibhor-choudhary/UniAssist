import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AppSettingsTab extends StatefulWidget {
  const AppSettingsTab({Key? key}) : super(key: key);

  @override
  State<AppSettingsTab> createState() => _AppSettingsTabState();
}

class _AppSettingsTabState extends State<AppSettingsTab> {
  // App settings state
  String _selectedLanguage = 'English';
  bool _highContrastMode = false;
  bool _voiceNavigation = false;
  String _themePreference = 'System';
  double _fontSize = 16.0;
  bool _dataUsageOptimization = true;
  bool _offlineMode = false;
  bool _analyticsSharing = true;
  bool _crashReporting = true;

  Future<void> _saveAppSettings() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('App settings saved successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  Future<void> _exportData() async {
    // Simulate data export
    await Future.delayed(Duration(seconds: 2));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data exported successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  Future<void> _clearCache() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear Cache'),
          content: Text('This will clear all cached data. Are you sure?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // Simulate cache clearing
                await Future.delayed(Duration(seconds: 1));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cache cleared successfully'),
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                  ),
                );
              },
              child: Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Language & Localization
          _buildSectionHeader('Language & Localization', 'language'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildDropdownTile(
                    'Language',
                    'Select your preferred language',
                    _selectedLanguage,
                    ['English', 'Hindi', 'हिंदी'],
                    (value) => setState(() => _selectedLanguage = value!),
                    'language',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Accessibility Settings
          _buildSectionHeader('Accessibility', 'accessibility'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  // Font Size Slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'text_fields',
                            size: 5.w,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Font Size',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  'Adjust text size for better readability',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text('A', style: TextStyle(fontSize: 12)),
                          Expanded(
                            child: Slider(
                              value: _fontSize,
                              min: 12.0,
                              max: 24.0,
                              divisions: 6,
                              label: '${_fontSize.round()}sp',
                              onChanged: (value) =>
                                  setState(() => _fontSize = value),
                            ),
                          ),
                          Text('A', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  _buildSwitchTile(
                    'High Contrast Mode',
                    'Increase contrast for better visibility',
                    _highContrastMode,
                    (value) => setState(() => _highContrastMode = value),
                    'contrast',
                  ),

                  _buildSwitchTile(
                    'Voice Navigation',
                    'Enable voice commands and audio feedback',
                    _voiceNavigation,
                    (value) => setState(() => _voiceNavigation = value),
                    'record_voice_over',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Theme Settings
          _buildSectionHeader('Theme & Display', 'palette'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildDropdownTile(
                    'Theme Preference',
                    'Choose your preferred app theme',
                    _themePreference,
                    ['Light', 'Dark', 'System'],
                    (value) => setState(() => _themePreference = value!),
                    'palette',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Data & Storage
          _buildSectionHeader('Data & Storage', 'storage'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildSwitchTile(
                    'Data Usage Optimization',
                    'Reduce data consumption',
                    _dataUsageOptimization,
                    (value) => setState(() => _dataUsageOptimization = value),
                    'data_usage',
                  ),

                  _buildSwitchTile(
                    'Offline Mode',
                    'Cache data for offline access',
                    _offlineMode,
                    (value) => setState(() => _offlineMode = value),
                    'offline_bolt',
                  ),

                  SizedBox(height: 2.h),

                  // Storage Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _exportData,
                          icon: CustomIconWidget(
                            iconName: 'download',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                          label: Text('Export Data'),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _clearCache,
                          icon: CustomIconWidget(
                            iconName: 'clear_all',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.error,
                          ),
                          label: Text(
                            'Clear Cache',
                            style: TextStyle(
                              color: AppTheme.lightTheme.colorScheme.error,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.lightTheme.colorScheme.error,
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

          // Privacy & Security
          _buildSectionHeader('Privacy & Security', 'security'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildSwitchTile(
                    'Analytics Sharing',
                    'Help improve the app by sharing usage data',
                    _analyticsSharing,
                    (value) => setState(() => _analyticsSharing = value),
                    'analytics',
                  ),

                  _buildSwitchTile(
                    'Crash Reporting',
                    'Automatically report crashes to help fix issues',
                    _crashReporting,
                    (value) => setState(() => _crashReporting = value),
                    'bug_report',
                  ),

                  SizedBox(height: 2.h),

                  // Privacy Actions
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'privacy_tip',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'View our privacy policy and data handling practices',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    trailing: CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      size: 4.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    onTap: () {
                      // Navigate to privacy policy
                    },
                  ),

                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'gavel',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    title: Text(
                      'Terms of Service',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Read our terms and conditions',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    trailing: CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      size: 4.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    onTap: () {
                      // Navigate to terms of service
                    },
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // App Information
          _buildSectionHeader('About', 'info'),
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'info',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    title: Text(
                      'App Version',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Campus Copilot v2.1.0',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ),
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'help',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    title: Text(
                      'Help & Support',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Get help and contact support',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    trailing: CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      size: 4.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    onTap: () {
                      // Navigate to help & support
                    },
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
              onPressed: _saveAppSettings,
              child: Text('Save Settings'),
            ),
          ),

          SizedBox(height: 2.h),

          // Powered by footer
          Center(
            child: Text(
              'Powered by Campus Copilot',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
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
