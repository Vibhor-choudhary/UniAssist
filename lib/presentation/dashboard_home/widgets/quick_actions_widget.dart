import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickActions = [
      {
        "title": "Mark Attendance",
        "icon": "check_circle",
        "color": AppTheme.getSuccessColor(true),
        "route": "/attendance-tracker",
      },
      {
        "title": "Submit Assignment",
        "icon": "upload_file",
        "color": AppTheme.lightTheme.primaryColor,
        "route": "/assignment-tracker",
      },
      {
        "title": "View Grades",
        "icon": "grade",
        "color": AppTheme.getWarningColor(true),
        "route": "/grades",
      },
      {
        "title": "Campus Map",
        "icon": "map",
        "color": AppTheme.lightTheme.colorScheme.secondary,
        "route": "/campus-map",
      },
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'flash_on',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Quick Actions',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: quickActions.length,
              itemBuilder: (context, index) {
                final action = quickActions[index];
                return InkWell(
                  onTap: () {
                    final route = action["route"] as String;
                    if (route.isNotEmpty) {
                      Navigator.pushNamed(context, route);
                    }
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (action["color"] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            (action["color"] as Color).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: action["icon"] as String,
                          color: action["color"] as Color,
                          size: 32,
                        ),
                        SizedBox(height: 8),
                        Text(
                          action["title"] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: action["color"] as Color,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
