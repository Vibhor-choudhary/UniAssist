import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SortDropdownWidget extends StatelessWidget {
  final String selectedSort;
  final Function(String) onSortChanged;

  const SortDropdownWidget({
    Key? key,
    required this.selectedSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      'Due Date',
      'Priority',
      'Course',
      'Progress',
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'sort',
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
          SizedBox(width: 2.w),
          Text(
            'Sort by:',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedSort,
                  isExpanded: true,
                  icon: CustomIconWidget(
                    iconName: 'keyboard_arrow_down',
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  items: sortOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: _getSortIcon(option),
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 16,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            option,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onSortChanged(newValue);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSortIcon(String sortOption) {
    switch (sortOption) {
      case 'Due Date':
        return 'schedule';
      case 'Priority':
        return 'priority_high';
      case 'Course':
        return 'school';
      case 'Progress':
        return 'trending_up';
      default:
        return 'sort';
    }
  }
}
