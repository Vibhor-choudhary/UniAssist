import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<String> categories;
  final List<String> selectedCategories;
  final Function(String) onCategoryToggle;
  final VoidCallback? onClearAll;

  const FilterChipsWidget({
    Key? key,
    required this.categories,
    required this.selectedCategories,
    required this.onCategoryToggle,
    this.onClearAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Filter by Category',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              if (selectedCategories.isNotEmpty)
                TextButton(
                  onPressed: onClearAll,
                  child: Text(
                    'Clear All',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...categories.map((category) => _buildFilterChip(category)),
                SizedBox(width: 2.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final bool isSelected = selectedCategories.contains(category);

    return Container(
      margin: EdgeInsets.only(right: 2.w),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: _getCategoryIcon(category),
              color: isSelected
                  ? AppTheme.lightTheme.colorScheme.onPrimary
                  : AppTheme.lightTheme.primaryColor,
              size: 4.w,
            ),
            SizedBox(width: 1.w),
            Text(
              category,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.onPrimary
                    : AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) => onCategoryToggle(category),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedColor: AppTheme.lightTheme.primaryColor,
        checkmarkColor: AppTheme.lightTheme.colorScheme.onPrimary,
        side: BorderSide(
          color: isSelected
              ? AppTheme.lightTheme.primaryColor
              : AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
      case 'all':
        return 'select_all';
      default:
        return 'notifications';
    }
  }
}
