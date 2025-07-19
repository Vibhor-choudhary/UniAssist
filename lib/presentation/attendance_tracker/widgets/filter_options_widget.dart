import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class FilterOptionsWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onFiltersChanged;
  final Map<String, dynamic> currentFilters;

  const FilterOptionsWidget({
    Key? key,
    required this.onFiltersChanged,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<FilterOptionsWidget> createState() => _FilterOptionsWidgetState();
}

class _FilterOptionsWidgetState extends State<FilterOptionsWidget> {
  late Map<String, dynamic> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.currentFilters);
  }

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
                  "Filter Options",
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _clearFilters,
                  child: Text("Clear All"),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildSemesterFilter(),
            SizedBox(height: 2.h),
            _buildCourseTypeFilter(),
            SizedBox(height: 2.h),
            _buildDateRangeFilter(),
            SizedBox(height: 2.h),
            _buildStatusFilter(),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text("Apply Filters"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Semester",
          style: AppTheme.lightTheme.textTheme.titleSmall,
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children:
              ['All', 'Semester 1', 'Semester 2', 'Semester 3', 'Semester 4']
                  .map((semester) => FilterChip(
                        label: Text(semester),
                        selected: _filters['semester'] == semester,
                        onSelected: (selected) {
                          setState(() {
                            _filters['semester'] = selected ? semester : 'All';
                          });
                        },
                        selectedColor: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.2),
                        checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
                      ))
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildCourseTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Course Type",
          style: AppTheme.lightTheme.textTheme.titleSmall,
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: ['All', 'Core', 'Elective', 'Lab', 'Project']
              .map((type) => FilterChip(
                    label: Text(type),
                    selected: _filters['courseType'] == type,
                    onSelected: (selected) {
                      setState(() {
                        _filters['courseType'] = selected ? type : 'All';
                      });
                    },
                    selectedColor: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.2),
                    checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDateRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date Range",
          style: AppTheme.lightTheme.textTheme.titleSmall,
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _selectDate(context, 'startDate'),
                child: Text(
                  _filters['startDate'] != null
                      ? _formatDate(_filters['startDate'])
                      : "Start Date",
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Text("to"),
            SizedBox(width: 2.w),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _selectDate(context, 'endDate'),
                child: Text(
                  _filters['endDate'] != null
                      ? _formatDate(_filters['endDate'])
                      : "End Date",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attendance Status",
          style: AppTheme.lightTheme.textTheme.titleSmall,
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children:
              ['All', 'Excellent (≥75%)', 'Warning (65-75%)', 'Critical (<65%)']
                  .map((status) => FilterChip(
                        label: Text(
                          status,
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        selected: _filters['status'] == status,
                        onSelected: (selected) {
                          setState(() {
                            _filters['status'] = selected ? status : 'All';
                          });
                        },
                        selectedColor: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.2),
                        checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
                      ))
                  .toList(),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, String dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _filters[dateType] ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _filters[dateType] = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  void _clearFilters() {
    setState(() {
      _filters = {
        'semester': 'All',
        'courseType': 'All',
        'status': 'All',
        'startDate': null,
        'endDate': null,
      };
    });
  }

  void _applyFilters() {
    widget.onFiltersChanged(_filters);
  }
}
