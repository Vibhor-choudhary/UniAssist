import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AcademicDetailsTab extends StatefulWidget {
  const AcademicDetailsTab({Key? key}) : super(key: key);

  @override
  State<AcademicDetailsTab> createState() => _AcademicDetailsTabState();
}

class _AcademicDetailsTabState extends State<AcademicDetailsTab> {
  // Mock academic data
  final Map<String, dynamic> academicData = {
    "registrationNumber": "12345678",
    "program": "B.Tech Computer Science Engineering",
    "school": "School of Computer Science & Engineering",
    "currentSemester": "6th Semester",
    "batch": "2021-2025",
    "cgpa": "8.75",
    "connectedAccounts": [
      {
        "name": "e-Connect",
        "status": "Connected",
        "lastSync": "2 hours ago",
        "isConnected": true,
      },
      {
        "name": "UMS",
        "status": "Connected",
        "lastSync": "1 day ago",
        "isConnected": true,
      },
      {
        "name": "LMS",
        "status": "Disconnected",
        "lastSync": "Never",
        "isConnected": false,
      },
    ],
  };

  Future<void> _syncAccount(String accountName) async {
    setState(() {
      // Update sync status
      final account = (academicData["connectedAccounts"] as List)
          .firstWhere((acc) => acc["name"] == accountName);
      account["lastSync"] = "Just now";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$accountName synced successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  Future<void> _connectAccount(String accountName) async {
    setState(() {
      final account = (academicData["connectedAccounts"] as List)
          .firstWhere((acc) => acc["name"] == accountName);
      account["isConnected"] = true;
      account["status"] = "Connected";
      account["lastSync"] = "Just now";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$accountName connected successfully'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Academic Information Card
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'school',
                        size: 6.w,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Academic Information',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  _buildInfoRow('Registration Number',
                      academicData["registrationNumber"]),
                  _buildInfoRow('Program', academicData["program"]),
                  _buildInfoRow('School', academicData["school"]),
                  _buildInfoRow(
                      'Current Semester', academicData["currentSemester"]),
                  _buildInfoRow('Batch', academicData["batch"]),
                  _buildInfoRow('CGPA', academicData["cgpa"]),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Connected Accounts Section
          Text(
            'Connected University Accounts',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Account Cards
          ...(academicData["connectedAccounts"] as List).map((account) {
            return Card(
              margin: EdgeInsets.only(bottom: 2.h),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    // Account Icon
                    Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: account["isConnected"]
                            ? AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.1)
                            : AppTheme.lightTheme.colorScheme.error
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: CustomIconWidget(
                        iconName: _getAccountIcon(account["name"]),
                        size: 6.w,
                        color: account["isConnected"]
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.error,
                      ),
                    ),

                    SizedBox(width: 4.w),

                    // Account Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account["name"],
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Row(
                            children: [
                              Container(
                                width: 2.w,
                                height: 2.w,
                                decoration: BoxDecoration(
                                  color: account["isConnected"]
                                      ? AppTheme.lightTheme.colorScheme.primary
                                      : AppTheme.lightTheme.colorScheme.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                account["status"],
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: account["isConnected"]
                                      ? AppTheme.lightTheme.colorScheme.primary
                                      : AppTheme.lightTheme.colorScheme.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Last sync: ${account["lastSync"]}',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),

                    // Action Button
                    account["isConnected"]
                        ? OutlinedButton(
                            onPressed: () => _syncAccount(account["name"]),
                            child: Text('Sync'),
                          )
                        : ElevatedButton(
                            onPressed: () => _connectAccount(account["name"]),
                            child: Text('Connect'),
                          ),
                  ],
                ),
              ),
            );
          }).toList(),

          SizedBox(height: 3.h),

          // Verification Status Card
          Card(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'verified',
                        size: 6.w,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Verification Status',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'check_circle',
                              size: 4.w,
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Verified Student',
                              style: AppTheme.lightTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAccountIcon(String accountName) {
    switch (accountName) {
      case 'e-Connect':
        return 'connect_without_contact';
      case 'UMS':
        return 'manage_accounts';
      case 'LMS':
        return 'library_books';
      default:
        return 'account_circle';
    }
  }
}
