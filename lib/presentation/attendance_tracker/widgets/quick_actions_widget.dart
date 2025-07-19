import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionsWidget extends StatelessWidget {
  final VoidCallback? onBulkMark;
  final VoidCallback? onAppealSubmit;
  final VoidCallback? onExportData;
  final VoidCallback? onSyncData;

  const QuickActionsWidget({
    Key? key,
    this.onBulkMark,
    this.onAppealSubmit,
    this.onExportData,
    this.onSyncData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Actions",
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 2.h,
              crossAxisSpacing: 4.w,
              childAspectRatio: 2.5,
              children: [
                _buildActionButton(
                  icon: 'edit',
                  label: 'Bulk Mark',
                  subtitle: 'Mark multiple classes',
                  onTap: onBulkMark,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
                _buildActionButton(
                  icon: 'report_problem',
                  label: 'Submit Appeal',
                  subtitle: 'Contest attendance',
                  onTap: onAppealSubmit,
                  color: AppTheme.getWarningColor(true),
                ),
                _buildActionButton(
                  icon: 'download',
                  label: 'Export Data',
                  subtitle: 'Download reports',
                  onTap: onExportData,
                  color: AppTheme.getSuccessColor(true),
                ),
                _buildActionButton(
                  icon: 'sync',
                  label: 'Sync Data',
                  subtitle: 'Refresh from server',
                  onTap: onSyncData,
                  color: AppTheme.lightTheme.colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required String subtitle,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
