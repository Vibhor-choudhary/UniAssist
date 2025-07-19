import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LpuBrandingWidget extends StatelessWidget {
  const LpuBrandingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // LPU Logo and Campus Copilot Branding
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            children: [
              // LPU Logo
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'LPU',
                    style:
                        AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),

              // Campus Copilot Title
              Text(
                'Campus Copilot',
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 1.h),

              // Subtitle
              Text(
                'Your AI-powered campus companion',
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 0.5.h),

              // Educational Icons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '📚',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '🎓',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '📱',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '🚀',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Welcome Message
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.secondary
                .withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.secondary
                  .withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Welcome to LPU',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                'Sign in to access your unified campus management platform',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
