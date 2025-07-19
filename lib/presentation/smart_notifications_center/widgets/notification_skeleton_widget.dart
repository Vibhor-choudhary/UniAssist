import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class NotificationSkeletonWidget extends StatefulWidget {
  const NotificationSkeletonWidget({Key? key}) : super(key: key);

  @override
  State<NotificationSkeletonWidget> createState() =>
      _NotificationSkeletonWidgetState();
}

class _NotificationSkeletonWidgetState extends State<NotificationSkeletonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildShimmerContainer(
                        width: 10.w,
                        height: 10.w,
                        borderRadius: 5.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildShimmerContainer(
                              width: 40.w,
                              height: 4.w,
                              borderRadius: 2,
                            ),
                            SizedBox(height: 1.h),
                            _buildShimmerContainer(
                              width: 25.w,
                              height: 3.w,
                              borderRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      _buildShimmerContainer(
                        width: 15.w,
                        height: 6.w,
                        borderRadius: 12,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  _buildShimmerContainer(
                    width: 80.w,
                    height: 4.w,
                    borderRadius: 2,
                  ),
                  SizedBox(height: 1.h),
                  _buildShimmerContainer(
                    width: 60.w,
                    height: 4.w,
                    borderRadius: 2,
                  ),
                  SizedBox(height: 1.h),
                  _buildShimmerContainer(
                    width: 70.w,
                    height: 3.w,
                    borderRadius: 2,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      _buildShimmerContainer(
                        width: 20.w,
                        height: 6.w,
                        borderRadius: 16,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          _buildShimmerContainer(
                            width: 8.w,
                            height: 8.w,
                            borderRadius: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          _buildShimmerContainer(
                            width: 8.w,
                            height: 8.w,
                            borderRadius: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          _buildShimmerContainer(
                            width: 8.w,
                            height: 8.w,
                            borderRadius: 4.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerContainer({
    required double width,
    required double height,
    required double borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.onSurface
            .withValues(alpha: _animation.value * 0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
