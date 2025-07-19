import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BatchOperationsToolbarWidget extends StatelessWidget {
  final int selectedCount;
  final VoidCallback? onMarkAllAsRead;
  final VoidCallback? onArchiveAll;
  final VoidCallback? onDeleteAll;
  final VoidCallback? onSelectAll;
  final VoidCallback? onClearSelection;

  const BatchOperationsToolbarWidget({
    Key? key,
    required this.selectedCount,
    this.onMarkAllAsRead,
    this.onArchiveAll,
    this.onDeleteAll,
    this.onSelectAll,
    this.onClearSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: selectedCount > 0 ? 15.h : 0,
      child: selectedCount > 0
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 6.w,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        '$selectedCount notification${selectedCount > 1 ? 's' : ''} selected',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.lightTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: onSelectAll,
                        child: Text(
                          'Select All',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: onClearSelection,
                        child: Text(
                          'Clear',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildBatchActionButton(
                          icon: 'mark_email_read',
                          label: 'Mark Read',
                          onTap: onMarkAllAsRead,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildBatchActionButton(
                          icon: 'archive',
                          label: 'Archive',
                          onTap: onArchiveAll,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildBatchActionButton(
                          icon: 'delete',
                          label: 'Delete',
                          onTap: onDeleteAll,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _buildBatchActionButton({
    required String icon,
    required String label,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color.withValues(alpha: 0.3)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 5.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
