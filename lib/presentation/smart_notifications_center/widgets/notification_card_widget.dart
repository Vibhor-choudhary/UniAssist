import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NotificationCardWidget extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback? onTap;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onArchive;
  final VoidCallback? onRespond;
  final bool isSelected;
  final VoidCallback? onSelectionChanged;

  const NotificationCardWidget({
    Key? key,
    required this.notification,
    this.onTap,
    this.onMarkAsRead,
    this.onArchive,
    this.onRespond,
    this.isSelected = false,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRead = notification['isRead'] ?? false;
    final String priority = notification['priority'] ?? 'low';
    final String category = notification['category'] ?? 'general';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Card(
        elevation: isRead ? 2 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isSelected
              ? BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: onTap,
          onLongPress: onSelectionChanged,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (onSelectionChanged != null)
                      GestureDetector(
                        onTap: onSelectionChanged,
                        child: Container(
                          width: 6.w,
                          height: 6.w,
                          margin: EdgeInsets.only(right: 3.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.lightTheme.primaryColor
                                  : Colors.grey,
                              width: 2,
                            ),
                            color: isSelected
                                ? AppTheme.lightTheme.primaryColor
                                : Colors.transparent,
                          ),
                          child: isSelected
                              ? CustomIconWidget(
                                  iconName: 'check',
                                  color: Colors.white,
                                  size: 4.w,
                                )
                              : null,
                        ),
                      ),
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 5.w,
                            backgroundColor: AppTheme.lightTheme.primaryColor
                                .withValues(alpha: 0.1),
                            child: CustomIconWidget(
                              iconName: _getCategoryIcon(category),
                              color: AppTheme.lightTheme.primaryColor,
                              size: 5.w,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification['sender'] ?? 'Unknown Sender',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleSmall
                                      ?.copyWith(
                                    fontWeight: isRead
                                        ? FontWeight.w400
                                        : FontWeight.w600,
                                    color: isRead
                                        ? AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant
                                        : AppTheme
                                            .lightTheme.colorScheme.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  _formatTimestamp(notification['timestamp']),
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildPriorityBadge(priority),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  notification['subject'] ?? 'No Subject',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                    color: isRead
                        ? AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        : AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (notification['preview'] != null) ...[
                  SizedBox(height: 1.h),
                  Text(
                    notification['preview'],
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 2.h),
                Row(
                  children: [
                    _buildCategoryChip(category),
                    Spacer(),
                    _buildActionButtons(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color badgeColor;
    String badgeText;

    switch (priority.toLowerCase()) {
      case 'urgent':
        badgeColor = Colors.red;
        badgeText = 'URGENT';
        break;
      case 'high':
        badgeColor = Colors.orange;
        badgeText = 'HIGH';
        break;
      case 'medium':
        badgeColor = Colors.blue;
        badgeText = 'MEDIUM';
        break;
      default:
        badgeColor = Colors.grey;
        badgeText = 'LOW';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        badgeText,
        style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primaryContainer
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: _getCategoryIcon(category),
            color: AppTheme.lightTheme.primaryColor,
            size: 3.w,
          ),
          SizedBox(width: 1.w),
          Text(
            category.toUpperCase(),
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.lightTheme.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!(notification['isRead'] ?? false))
          _buildActionButton(
            icon: 'mark_email_read',
            onTap: onMarkAsRead,
            tooltip: 'Mark as Read',
          ),
        SizedBox(width: 2.w),
        _buildActionButton(
          icon: 'archive',
          onTap: onArchive,
          tooltip: 'Archive',
        ),
        if (notification['canRespond'] ?? false) ...[
          SizedBox(width: 2.w),
          _buildActionButton(
            icon: 'reply',
            onTap: onRespond,
            tooltip: 'Respond',
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton({
    required String icon,
    required VoidCallback? onTap,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(2.w),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 4.w,
          ),
        ),
      ),
    );
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'academic':
        return 'school';
      case 'administrative':
        return 'business';
      case 'social':
        return 'people';
      case 'system':
        return 'settings';
      case 'deadline':
        return 'schedule';
      case 'announcement':
        return 'campaign';
      default:
        return 'notifications';
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Unknown time';

    DateTime dateTime;
    if (timestamp is DateTime) {
      dateTime = timestamp;
    } else if (timestamp is String) {
      dateTime = DateTime.tryParse(timestamp) ?? DateTime.now();
    } else {
      return 'Unknown time';
    }

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
