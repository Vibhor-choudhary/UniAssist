import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PredictiveAnalyticsCard extends StatelessWidget {
  final double currentPercentage;
  final int totalClasses;
  final int attendedClasses;

  const PredictiveAnalyticsCard({
    Key? key,
    required this.currentPercentage,
    required this.totalClasses,
    required this.attendedClasses,
  }) : super(key: key);

  Map<String, dynamic> _calculatePrediction() {
    if (currentPercentage >= 75) {
      return {
        'status': 'safe',
        'message': 'You\'re maintaining excellent attendance!',
        'recommendation':
            'Keep up the good work. You can miss up to ${_calculateMaxMissable()} more classes.',
        'color': AppTheme.getSuccessColor(true),
        'icon': 'check_circle',
      };
    } else if (currentPercentage >= 65) {
      final classesNeeded = _calculateClassesNeeded();
      return {
        'status': 'warning',
        'message': 'Attendance threshold warning!',
        'recommendation':
            'Attend next $classesNeeded classes to maintain 75% eligibility.',
        'color': AppTheme.getWarningColor(true),
        'icon': 'warning',
      };
    } else {
      final classesNeeded = _calculateClassesNeeded();
      return {
        'status': 'critical',
        'message': 'Critical attendance level!',
        'recommendation':
            'You must attend the next $classesNeeded classes consecutively to recover.',
        'color': AppTheme.getErrorColor(true),
        'icon': 'error',
      };
    }
  }

  int _calculateClassesNeeded() {
    // Calculate how many consecutive classes needed to reach 75%
    int classesNeeded = 0;
    double tempPercentage = currentPercentage;
    int tempTotal = totalClasses;
    int tempAttended = attendedClasses;

    while (tempPercentage < 75 && classesNeeded < 20) {
      tempTotal++;
      tempAttended++;
      tempPercentage = (tempAttended / tempTotal) * 100;
      classesNeeded++;
    }

    return classesNeeded;
  }

  int _calculateMaxMissable() {
    // Calculate maximum classes that can be missed while maintaining 75%
    int maxMissable = 0;
    double tempPercentage = currentPercentage;
    int tempTotal = totalClasses;

    while (tempPercentage >= 75 && maxMissable < 10) {
      tempTotal++;
      tempPercentage = (attendedClasses / tempTotal) * 100;
      if (tempPercentage >= 75) {
        maxMissable++;
      } else {
        break;
      }
    }

    return maxMissable;
  }

  @override
  Widget build(BuildContext context) {
    final prediction = _calculatePrediction();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'analytics',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Text(
                  "Predictive Analytics",
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: (prediction['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (prediction['color'] as Color).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: prediction['icon'] as String,
                        color: prediction['color'] as Color,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          prediction['message'] as String,
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            color: prediction['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    prediction['recommendation'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Current Status",
                    "${currentPercentage.toStringAsFixed(1)}%",
                    prediction['color'] as Color,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildStatCard(
                    "Target",
                    "75.0%",
                    AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
