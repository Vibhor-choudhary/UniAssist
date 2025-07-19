import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WorkloadChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> assignments;

  const WorkloadChartWidget({
    Key? key,
    required this.assignments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final workloadData = _generateWorkloadData();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'timeline',
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Workload Distribution',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '14 Days',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Container(
                height: 25.h,
                child: Semantics(
                  label:
                      "Workload Distribution Chart showing assignments over 14 days",
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: workloadData
                              .map((e) => e['count'] as double)
                              .reduce((a, b) => a > b ? a : b) +
                          2,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: isDarkMode
                              ? AppTheme.surfaceDark.withValues(alpha: 0.9)
                              : AppTheme.surfaceLight.withValues(alpha: 0.9),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final data = workloadData[group.x.toInt()];
                            return BarTooltipItem(
                              '${data['date']}\n${data['count'].toInt()} assignments',
                              TextStyle(
                                color: isDarkMode
                                    ? AppTheme.textPrimaryDark
                                    : AppTheme.textPrimaryLight,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < workloadData.length) {
                                final data = workloadData[value.toInt()];
                                return Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: Text(
                                    data['shortDate'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            },
                            reservedSize: 4.h,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Text(
                                value.toInt().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              );
                            },
                            reservedSize: 8.w,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.3),
                            width: 1,
                          ),
                          left: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      barGroups: workloadData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final count = data['count'] as double;

                        Color barColor;
                        if (count >= 4) {
                          barColor = isDarkMode
                              ? AppTheme.errorDark
                              : AppTheme.errorLight;
                        } else if (count >= 2) {
                          barColor = isDarkMode
                              ? AppTheme.warningDark
                              : AppTheme.warningLight;
                        } else {
                          barColor = Theme.of(context).colorScheme.primary;
                        }

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: count,
                              color: barColor,
                              width: 4.w,
                              borderRadius: BorderRadius.circular(2),
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                toY: workloadData
                                        .map((e) => e['count'] as double)
                                        .reduce((a, b) => a > b ? a : b) +
                                    1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withValues(alpha: 0.1),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.1),
                            strokeWidth: 1,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildLegendItem(context, 'Low (1-2)',
                      Theme.of(context).colorScheme.primary),
                  _buildLegendItem(
                      context,
                      'Medium (3-4)',
                      isDarkMode
                          ? AppTheme.warningDark
                          : AppTheme.warningLight),
                  _buildLegendItem(context, 'High (5+)',
                      isDarkMode ? AppTheme.errorDark : AppTheme.errorLight),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 3.w,
          height: 3.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _generateWorkloadData() {
    final List<Map<String, dynamic>> data = [];
    final now = DateTime.now();

    for (int i = 0; i < 14; i++) {
      final date = now.add(Duration(days: i));
      final assignmentsOnDate = assignments.where((assignment) {
        final dueDate = assignment['dueDate'] as DateTime? ?? DateTime.now();
        return dueDate.year == date.year &&
            dueDate.month == date.month &&
            dueDate.day == date.day;
      }).length;

      data.add({
        'date': '${date.day}/${date.month}',
        'shortDate': '${date.day}',
        'count': assignmentsOnDate.toDouble(),
      });
    }

    return data;
  }
}
