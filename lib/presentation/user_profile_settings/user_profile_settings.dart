import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/academic_details_tab.dart';
import './widgets/app_settings_tab.dart';
import './widgets/notification_preferences_tab.dart';
import './widgets/password_change_widget.dart';
import './widgets/personal_info_tab.dart';

class UserProfileSettings extends StatefulWidget {
  const UserProfileSettings({Key? key}) : super(key: key);

  @override
  State<UserProfileSettings> createState() => _UserProfileSettingsState();
}

class _UserProfileSettingsState extends State<UserProfileSettings>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'Personal',
      'icon': 'person',
      'widget': PersonalInfoTab(),
    },
    {
      'title': 'Academic',
      'icon': 'school',
      'widget': AcademicDetailsTab(),
    },
    {
      'title': 'Notifications',
      'icon': 'notifications',
      'widget': NotificationPreferencesTab(),
    },
    {
      'title': 'App Settings',
      'icon': 'settings',
      'widget': AppSettingsTab(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile Settings',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            size: 6.w,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
            onSelected: _navigateToScreen,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: '/dashboard-home',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'home',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    SizedBox(width: 3.w),
                    Text('Dashboard'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/smart-notifications-center',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'notifications',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    SizedBox(width: 3.w),
                    Text('Notifications'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/attendance-tracker',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'event_available',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    SizedBox(width: 3.w),
                    Text('Attendance'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: '/assignment-tracker',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'assignment',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    SizedBox(width: 3.w),
                    Text('Assignments'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: '/login-screen',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'logout',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.error,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: AppTheme.lightTheme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((tab) {
            final index = _tabs.indexOf(tab);
            final isSelected = index == _currentIndex;

            return Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: tab['icon'],
                      size: 4.w,
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      tab['title'],
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          // User Profile Header
          Container(
            width: double.infinity,
            color: AppTheme.lightTheme.colorScheme.surface,
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CustomImageWidget(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 4.w),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rajesh Kumar',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'B.Tech Computer Science Engineering',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          Container(
                            width: 2.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Verified Student',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Quick Actions
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Quick edit profile
                      },
                      icon: CustomIconWidget(
                        iconName: 'edit',
                        size: 5.w,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Edit',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _tabs[0]['widget'],
                _tabs[1]['widget'],
                _tabs[2]['widget'],
                Column(
                  children: [
                    Expanded(child: _tabs[3]['widget']),
                    // Password Change Widget for App Settings tab
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: PasswordChangeWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom Navigation for quick access
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4, // Profile settings is selected
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateToScreen('/dashboard-home');
              break;
            case 1:
              _navigateToScreen('/smart-notifications-center');
              break;
            case 2:
              _navigateToScreen('/attendance-tracker');
              break;
            case 3:
              _navigateToScreen('/assignment-tracker');
              break;
            case 4:
              // Already on profile settings
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'home',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'notifications',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'notifications',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'event_available',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'event_available',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'assignment',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'assignment',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'person',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
