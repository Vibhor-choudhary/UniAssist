import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class FilterChipsWidget extends StatelessWidget {
  final String selectedCourse;
  final String selectedType;
  final String selectedStatus;
  final List<String> courses;
  final List<String> types;
  final List<String> statuses;
  final Function(String) onCourseChanged;
  final Function(String) onTypeChanged;
  final Function(String) onStatusChanged;
  final VoidCallback onClearFilters;

  const FilterChipsWidget({
    Key? key,
    required this.selectedCourse,
    required this.selectedType,
    required this.selectedStatus,
    required this.courses,
    required this.types,
    required this.statuses,
    required this.onCourseChanged,
    required this.onTypeChanged,
    required this.onStatusChanged,
    required this.onClearFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Spacer(),
              if (_hasActiveFilters())
                TextButton(
                  onPressed: onClearFilters,
                  child: Text(
                    'Clear All',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
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
                _buildFilterSection(
                  context,
                  'Course',
                  selectedCourse,
                  courses,
                  onCourseChanged,
                  'school',
                ),
                SizedBox(width: 3.w),
                _buildFilterSection(
                  context,
                  'Type',
                  selectedType,
                  types,
                  onTypeChanged,
                  'assignment',
                ),
                SizedBox(width: 3.w),
                _buildFilterSection(
                  context,
                  'Status',
                  selectedStatus,
                  statuses,
                  onStatusChanged,
                  'flag',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    BuildContext context,
    String title,
    String selectedValue,
    List<String> options,
    Function(String) onChanged,
    String iconName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 16,
            ),
            SizedBox(width: 1.w),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return FilterChip(
              label: Text(
                option,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onChanged(option);
                } else {
                  onChanged('All');
                }
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).colorScheme.primary,
              checkmarkColor: Theme.of(context).colorScheme.onPrimary,
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            );
          }).toList(),
        ),
      ],
    );
  }

  bool _hasActiveFilters() {
    return selectedCourse != 'All' ||
        selectedType != 'All' ||
        selectedStatus != 'All';
  }
}
