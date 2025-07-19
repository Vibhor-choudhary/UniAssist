import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/batch_operations_toolbar_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/notification_card_widget.dart';
import './widgets/notification_skeleton_widget.dart';
import './widgets/search_bar_widget.dart';

class SmartNotificationsCenter extends StatefulWidget {
  const SmartNotificationsCenter({Key? key}) : super(key: key);

  @override
  State<SmartNotificationsCenter> createState() =>
      _SmartNotificationsCenterState();
}

class _SmartNotificationsCenterState extends State<SmartNotificationsCenter> {
  final ScrollController _scrollController = ScrollController();

  // State variables
  List<Map<String, dynamic>> _allNotifications = [];
  List<Map<String, dynamic>> _filteredNotifications = [];
  List<String> _selectedCategories = [];
  List<int> _selectedNotificationIds = [];
  String _searchQuery = '';
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  int _currentPage = 1;

  // Filter categories
  final List<String> _categories = [
    'All',
    'Academic',
    'Administrative',
    'Social',
    'System',
    'Deadline',
    'Announcement'
  ];

  // Search suggestions
  final List<String> _searchSuggestions = [
    'Assignment deadline',
    'Fee payment',
    'Exam schedule',
    'Library notification',
    'Course registration',
    'Attendance alert',
    'Grade update',
    'Event invitation',
    'System maintenance',
    'Holiday announcement'
  ];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMoreData) {
        _loadMoreNotifications();
      }
    }
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 1500));

    final notifications = _generateMockNotifications();

    setState(() {
      _allNotifications = notifications;
      _filteredNotifications = notifications;
      _isLoading = false;
      _currentPage = 1;
    });
  }

  Future<void> _loadMoreNotifications() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(Duration(milliseconds: 800));

    final moreNotifications =
        _generateMockNotifications(page: _currentPage + 1);

    setState(() {
      if (moreNotifications.isNotEmpty) {
        _allNotifications.addAll(moreNotifications);
        _applyFilters();
        _currentPage++;
      } else {
        _hasMoreData = false;
      }
      _isLoadingMore = false;
    });
  }

  List<Map<String, dynamic>> _generateMockNotifications({int page = 1}) {
    if (page > 3) return []; // Simulate end of data after 3 pages

    final baseNotifications = [
      {
        "id": (page - 1) * 10 + 1,
        "sender": "Academic Office",
        "subject": "Assignment Submission Deadline - Data Structures",
        "preview":
            "Your assignment for Data Structures (CS301) is due tomorrow at 11:59 PM. Please ensure all files are uploaded to the portal.",
        "timestamp": DateTime.now().subtract(Duration(hours: 2)),
        "priority": "urgent",
        "category": "academic",
        "isRead": false,
        "canRespond": false,
      },
      {
        "id": (page - 1) * 10 + 2,
        "sender": "Fee Collection Department",
        "subject": "Semester Fee Payment Reminder",
        "preview":
            "This is a reminder that your semester fee payment of ₹45,000 is due by 25th July 2025.",
        "timestamp": DateTime.now().subtract(Duration(hours: 5)),
        "priority": "high",
        "category": "administrative",
        "isRead": false,
        "canRespond": true,
      },
      {
        "id": (page - 1) * 10 + 3,
        "sender": "Student Activities Committee",
        "subject": "Annual Tech Fest 2025 - Registration Open",
        "preview":
            "Join us for the biggest tech fest of the year! Register now for various competitions and workshops.",
        "timestamp": DateTime.now().subtract(Duration(hours: 8)),
        "priority": "medium",
        "category": "social",
        "isRead": true,
        "canRespond": true,
      },
      {
        "id": (page - 1) * 10 + 4,
        "sender": "Library Services",
        "subject": "Book Return Reminder",
        "preview":
            "You have 2 books due for return by tomorrow. Please return them to avoid late fees.",
        "timestamp": DateTime.now().subtract(Duration(days: 1)),
        "priority": "medium",
        "category": "administrative",
        "isRead": false,
        "canRespond": false,
      },
      {
        "id": (page - 1) * 10 + 5,
        "sender": "IT Support",
        "subject": "System Maintenance Scheduled",
        "preview":
            "The university portal will be under maintenance on Sunday from 2 AM to 6 AM. Services will be unavailable.",
        "timestamp": DateTime.now().subtract(Duration(days: 1, hours: 3)),
        "priority": "low",
        "category": "system",
        "isRead": true,
        "canRespond": false,
      },
      {
        "id": (page - 1) * 10 + 6,
        "sender": "Examination Cell",
        "subject": "Mid-Semester Exam Schedule Released",
        "preview":
            "The mid-semester examination schedule has been published. Please check your exam dates and venues.",
        "timestamp": DateTime.now().subtract(Duration(days: 2)),
        "priority": "high",
        "category": "academic",
        "isRead": false,
        "canRespond": false,
      },
      {
        "id": (page - 1) * 10 + 7,
        "sender": "Hostel Administration",
        "subject": "Room Inspection Notice",
        "preview":
            "Room inspection will be conducted next week. Please ensure your rooms are clean and organized.",
        "timestamp": DateTime.now().subtract(Duration(days: 2, hours: 5)),
        "priority": "medium",
        "category": "administrative",
        "isRead": true,
        "canRespond": false,
      },
      {
        "id": (page - 1) * 10 + 8,
        "sender": "Career Services",
        "subject": "Campus Placement Drive - TCS",
        "preview":
            "TCS is conducting a campus placement drive next month. Eligible students can register through the portal.",
        "timestamp": DateTime.now().subtract(Duration(days: 3)),
        "priority": "high",
        "category": "announcement",
        "isRead": false,
        "canRespond": true,
      },
      {
        "id": (page - 1) * 10 + 9,
        "sender": "Sports Committee",
        "subject": "Inter-College Basketball Tournament",
        "preview":
            "Registration is now open for the inter-college basketball tournament. Form your teams and register by next Friday.",
        "timestamp": DateTime.now().subtract(Duration(days: 3, hours: 8)),
        "priority": "low",
        "category": "social",
        "isRead": true,
        "canRespond": true,
      },
      {
        "id": (page - 1) * 10 + 10,
        "sender": "Academic Coordinator",
        "subject": "Course Registration Deadline Extended",
        "preview":
            "The deadline for course registration has been extended to 30th July 2025. Complete your registration soon.",
        "timestamp": DateTime.now().subtract(Duration(days: 4)),
        "priority": "medium",
        "category": "academic",
        "isRead": false,
        "canRespond": false,
      },
    ];

    return baseNotifications;
  }

  void _applyFilters() {
    List<Map<String, dynamic>> filtered = List.from(_allNotifications);

    // Apply category filter
    if (_selectedCategories.isNotEmpty &&
        !_selectedCategories.contains('All')) {
      filtered = filtered.where((notification) {
        final category = (notification['category'] as String).toLowerCase();
        return _selectedCategories
            .any((selected) => selected.toLowerCase() == category);
      }).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((notification) {
        final searchLower = _searchQuery.toLowerCase();
        final sender = (notification['sender'] as String? ?? '').toLowerCase();
        final subject =
            (notification['subject'] as String? ?? '').toLowerCase();
        final preview =
            (notification['preview'] as String? ?? '').toLowerCase();

        return sender.contains(searchLower) ||
            subject.contains(searchLower) ||
            preview.contains(searchLower);
      }).toList();
    }

    // Sort by priority and timestamp
    filtered.sort((a, b) {
      final priorityOrder = {'urgent': 4, 'high': 3, 'medium': 2, 'low': 1};
      final aPriority = priorityOrder[a['priority']] ?? 1;
      final bPriority = priorityOrder[b['priority']] ?? 1;

      if (aPriority != bPriority) {
        return bPriority.compareTo(aPriority);
      }

      final aTime = a['timestamp'] as DateTime? ?? DateTime.now();
      final bTime = b['timestamp'] as DateTime? ?? DateTime.now();
      return bTime.compareTo(aTime);
    });

    setState(() {
      _filteredNotifications = filtered;
    });
  }

  void _onCategoryToggle(String category) {
    setState(() {
      if (category == 'All') {
        _selectedCategories.clear();
        _selectedCategories.add('All');
      } else {
        _selectedCategories.remove('All');
        if (_selectedCategories.contains(category)) {
          _selectedCategories.remove(category);
        } else {
          _selectedCategories.add(category);
        }

        if (_selectedCategories.isEmpty) {
          _selectedCategories.add('All');
        }
      }
    });
    _applyFilters();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  void _clearFilters() {
    setState(() {
      _selectedCategories.clear();
      _selectedCategories.add('All');
    });
    _applyFilters();
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
    });
    _applyFilters();
  }

  void _onNotificationTap(Map<String, dynamic> notification) {
    // Mark as read when tapped
    if (!(notification['isRead'] ?? false)) {
      _markAsRead(notification['id']);
    }

    // Show notification details
    _showNotificationDetails(notification);
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Text(
                    'Notification Details',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['subject'] ?? 'No Subject',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          'From: ${notification['sender'] ?? 'Unknown'}',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Text(
                          _formatDetailedTimestamp(notification['timestamp']),
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      notification['preview'] ?? 'No content available.',
                      style: AppTheme.lightTheme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDetailedTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Unknown time';

    DateTime dateTime;
    if (timestamp is DateTime) {
      dateTime = timestamp;
    } else if (timestamp is String) {
      dateTime = DateTime.tryParse(timestamp) ?? DateTime.now();
    } else {
      return 'Unknown time';
    }

    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _markAsRead(int notificationId) {
    setState(() {
      final index =
          _allNotifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        _allNotifications[index]['isRead'] = true;
      }
    });
    _applyFilters();
  }

  void _archiveNotification(int notificationId) {
    setState(() {
      _allNotifications.removeWhere((n) => n['id'] == notificationId);
    });
    _applyFilters();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification archived'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Implement undo functionality
          },
        ),
      ),
    );
  }

  void _respondToNotification(Map<String, dynamic> notification) {
    // Implement response functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Response feature coming soon')),
    );
  }

  void _onSelectionChanged(int notificationId) {
    setState(() {
      if (_selectedNotificationIds.contains(notificationId)) {
        _selectedNotificationIds.remove(notificationId);
      } else {
        _selectedNotificationIds.add(notificationId);
      }
    });
  }

  void _selectAllNotifications() {
    setState(() {
      _selectedNotificationIds =
          _filteredNotifications.map((n) => n['id'] as int).toList();
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedNotificationIds.clear();
    });
  }

  void _batchMarkAsRead() {
    setState(() {
      for (final id in _selectedNotificationIds) {
        final index = _allNotifications.indexWhere((n) => n['id'] == id);
        if (index != -1) {
          _allNotifications[index]['isRead'] = true;
        }
      }
      _selectedNotificationIds.clear();
    });
    _applyFilters();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifications marked as read')),
    );
  }

  void _batchArchive() {
    setState(() {
      _allNotifications
          .removeWhere((n) => _selectedNotificationIds.contains(n['id']));
      _selectedNotificationIds.clear();
    });
    _applyFilters();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifications archived')),
    );
  }

  void _batchDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Notifications'),
        content: Text(
            'Are you sure you want to delete ${_selectedNotificationIds.length} notifications? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _allNotifications.removeWhere(
                    (n) => _selectedNotificationIds.contains(n['id']));
                _selectedNotificationIds.clear();
              });
              _applyFilters();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notifications deleted')),
              );
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Text(
                    'Notification Settings',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(4.w),
                children: [
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'notifications_active',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 6.w,
                    ),
                    title: Text('Push Notifications'),
                    subtitle: Text('Receive notifications on your device'),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'priority_high',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 6.w,
                    ),
                    title: Text('Priority Alerts'),
                    subtitle:
                        Text('Get instant alerts for urgent notifications'),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'schedule',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 6.w,
                    ),
                    title: Text('Quiet Hours'),
                    subtitle: Text('No notifications from 10 PM to 8 AM'),
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ListTile(
                    leading: CustomIconWidget(
                      iconName: 'email',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 6.w,
                    ),
                    title: Text('Email Digest'),
                    subtitle: Text('Daily summary of notifications'),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount =
        _allNotifications.where((n) => !(n['isRead'] ?? false)).length;

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smart Notifications',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (unreadCount > 0)
              Text(
                '$unreadCount unread notifications',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                ),
              ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: _showNotificationSettings,
                icon: CustomIconWidget(
                  iconName: 'settings',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _loadNotifications,
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 6.w,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Column(
        children: [
          BatchOperationsToolbarWidget(
            selectedCount: _selectedNotificationIds.length,
            onMarkAllAsRead: _batchMarkAsRead,
            onArchiveAll: _batchArchive,
            onDeleteAll: _batchDelete,
            onSelectAll: _selectAllNotifications,
            onClearSelection: _clearSelection,
          ),
          SearchBarWidget(
            initialQuery: _searchQuery,
            onSearchChanged: _onSearchChanged,
            suggestions: _searchSuggestions,
            onClear: _clearSearch,
          ),
          SizedBox(height: 1.h),
          FilterChipsWidget(
            categories: _categories,
            selectedCategories:
                _selectedCategories.isEmpty ? ['All'] : _selectedCategories,
            onCategoryToggle: _onCategoryToggle,
            onClearAll: _clearFilters,
          ),
          Expanded(
            child: _isLoading
                ? ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        NotificationSkeletonWidget(),
                  )
                : _filteredNotifications.isEmpty
                    ? EmptyStateWidget(
                        title: _searchQuery.isNotEmpty ||
                                _selectedCategories.length > 1
                            ? 'No matching notifications'
                            : 'No notifications yet',
                        subtitle: _searchQuery.isNotEmpty ||
                                _selectedCategories.length > 1
                            ? 'Try adjusting your search or filters to find what you\'re looking for.'
                            : 'You\'re all caught up! New notifications will appear here when they arrive.',
                        iconName: _searchQuery.isNotEmpty ||
                                _selectedCategories.length > 1
                            ? 'search_off'
                            : 'notifications_none',
                        actionText: _searchQuery.isNotEmpty ||
                                _selectedCategories.length > 1
                            ? 'Clear Filters'
                            : null,
                        onActionPressed: _searchQuery.isNotEmpty ||
                                _selectedCategories.length > 1
                            ? () {
                                _clearSearch();
                                _clearFilters();
                              }
                            : null,
                      )
                    : RefreshIndicator(
                        onRefresh: _loadNotifications,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: _filteredNotifications.length +
                              (_isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _filteredNotifications.length) {
                              return Container(
                                padding: EdgeInsets.all(4.w),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.lightTheme.primaryColor,
                                  ),
                                ),
                              );
                            }

                            final notification = _filteredNotifications[index];
                            final notificationId = notification['id'] as int;

                            return NotificationCardWidget(
                              notification: notification,
                              isSelected: _selectedNotificationIds
                                  .contains(notificationId),
                              onTap: () => _onNotificationTap(notification),
                              onSelectionChanged: _selectedNotificationIds
                                      .isNotEmpty
                                  ? () => _onSelectionChanged(notificationId)
                                  : null,
                              onMarkAsRead: !(notification['isRead'] ?? false)
                                  ? () => _markAsRead(notificationId)
                                  : null,
                              onArchive: () =>
                                  _archiveNotification(notificationId),
                              onRespond: (notification['canRespond'] ?? false)
                                  ? () => _respondToNotification(notification)
                                  : null,
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Smart Notifications Center is at index 2
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/login-screen');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/dashboard-home');
              break;
            case 2:
              // Current screen
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/attendance-tracker');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/assignment-tracker');
              break;
            case 5:
              Navigator.pushReplacementNamed(context, '/user-profile-settings');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'login',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'login',
              color: AppTheme.lightTheme.primaryColor,
              size: 5.w,
            ),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'dashboard',
              color: AppTheme.lightTheme.primaryColor,
              size: 5.w,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                CustomIconWidget(
                  iconName: 'notifications',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 5.w,
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'event_available',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'event_available',
              color: AppTheme.lightTheme.primaryColor,
              size: 5.w,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'assignment',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'assignment',
              color: AppTheme.lightTheme.primaryColor,
              size: 5.w,
            ),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 5.w,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'person',
              color: AppTheme.lightTheme.primaryColor,
              size: 5.w,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
