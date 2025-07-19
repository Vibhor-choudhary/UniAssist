import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/attendance_overview_card.dart';
import './widgets/calendar_view_widget.dart';
import './widgets/course_attendance_card.dart';
import './widgets/filter_options_widget.dart';
import './widgets/predictive_analytics_card.dart';
import './widgets/quick_actions_widget.dart';

class AttendanceTracker extends StatefulWidget {
  const AttendanceTracker({Key? key}) : super(key: key);

  @override
  State<AttendanceTracker> createState() => _AttendanceTrackerState();
}

class _AttendanceTrackerState extends State<AttendanceTracker>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _showFilters = false;
  Map<String, dynamic> _currentFilters = {
    'semester': 'All',
    'courseType': 'All',
    'status': 'All',
    'startDate': null,
    'endDate': null,
  };

  // Mock data for attendance tracking
  final List<Map<String, dynamic>> _attendanceData = [
    {
      'courseCode': 'CSE101',
      'courseName': 'Introduction to Computer Science',
      'percentage': 85.5,
      'attended': 34,
      'total': 40,
      'trend': 'up',
      'type': 'Core',
      'semester': 'Semester 1',
      'records': [
        {
          'date': '15/07/2025',
          'status': 'Present',
          'topic': 'Introduction to Programming Concepts',
        },
        {
          'date': '14/07/2025',
          'status': 'Present',
          'topic': 'Data Structures Overview',
        },
        {
          'date': '13/07/2025',
          'status': 'Absent',
          'topic': 'Algorithm Analysis',
        },
        {
          'date': '12/07/2025',
          'status': 'Present',
          'topic': 'Object-Oriented Programming',
        },
        {
          'date': '11/07/2025',
          'status': 'Present',
          'topic': 'Database Fundamentals',
        },
      ],
    },
    {
      'courseCode': 'MAT201',
      'courseName': 'Advanced Mathematics for Engineers',
      'percentage': 72.3,
      'attended': 26,
      'total': 36,
      'trend': 'down',
      'type': 'Core',
      'semester': 'Semester 2',
      'records': [
        {
          'date': '15/07/2025',
          'status': 'Absent',
          'topic': 'Linear Algebra Applications',
        },
        {
          'date': '14/07/2025',
          'status': 'Present',
          'topic': 'Calculus in Engineering',
        },
        {
          'date': '13/07/2025',
          'status': 'Present',
          'topic': 'Differential Equations',
        },
        {
          'date': '12/07/2025',
          'status': 'Absent',
          'topic': 'Statistical Methods',
        },
        {
          'date': '11/07/2025',
          'status': 'Present',
          'topic': 'Probability Theory',
        },
      ],
    },
    {
      'courseCode': 'PHY301',
      'courseName': 'Engineering Physics Laboratory',
      'percentage': 91.2,
      'attended': 31,
      'total': 34,
      'trend': 'up',
      'type': 'Lab',
      'semester': 'Semester 3',
      'records': [
        {
          'date': '15/07/2025',
          'status': 'Present',
          'topic': 'Optics Experiments',
        },
        {
          'date': '14/07/2025',
          'status': 'Present',
          'topic': 'Electromagnetic Induction',
        },
        {
          'date': '13/07/2025',
          'status': 'Present',
          'topic': 'Wave Mechanics',
        },
        {
          'date': '12/07/2025',
          'status': 'Absent',
          'topic': 'Thermodynamics Lab',
        },
        {
          'date': '11/07/2025',
          'status': 'Present',
          'topic': 'Quantum Physics Demo',
        },
      ],
    },
    {
      'courseCode': 'ELE401',
      'courseName': 'Digital Signal Processing',
      'percentage': 63.8,
      'attended': 23,
      'total': 36,
      'trend': 'down',
      'type': 'Elective',
      'semester': 'Semester 4',
      'records': [
        {
          'date': '15/07/2025',
          'status': 'Absent',
          'topic': 'Fourier Transform Applications',
        },
        {
          'date': '14/07/2025',
          'status': 'Absent',
          'topic': 'Filter Design Techniques',
        },
        {
          'date': '13/07/2025',
          'status': 'Present',
          'topic': 'Z-Transform Analysis',
        },
        {
          'date': '12/07/2025',
          'status': 'Present',
          'topic': 'Digital Filter Implementation',
        },
        {
          'date': '11/07/2025',
          'status': 'Absent',
          'topic': 'Signal Sampling Theory',
        },
      ],
    },
    {
      'courseCode': 'MGT501',
      'courseName': 'Project Management Fundamentals',
      'percentage': 78.9,
      'attended': 30,
      'total': 38,
      'trend': 'flat',
      'type': 'Project',
      'semester': 'Semester 1',
      'records': [
        {
          'date': '15/07/2025',
          'status': 'Present',
          'topic': 'Agile Methodology Overview',
        },
        {
          'date': '14/07/2025',
          'status': 'Present',
          'topic': 'Risk Management Strategies',
        },
        {
          'date': '13/07/2025',
          'status': 'Absent',
          'topic': 'Team Leadership Skills',
        },
        {
          'date': '12/07/2025',
          'status': 'Present',
          'topic': 'Budget Planning Techniques',
        },
        {
          'date': '11/07/2025',
          'status': 'Present',
          'topic': 'Quality Assurance Methods',
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double get _overallAttendancePercentage {
    if (_attendanceData.isEmpty) return 0.0;

    int totalAttended = 0;
    int totalClasses = 0;

    for (final course in _filteredAttendanceData) {
      totalAttended += course['attended'] as int;
      totalClasses += course['total'] as int;
    }

    return totalClasses > 0 ? (totalAttended / totalClasses) * 100 : 0.0;
  }

  int get _totalClasses {
    return _filteredAttendanceData.fold(
        0, (sum, course) => sum + (course['total'] as int));
  }

  int get _totalAttendedClasses {
    return _filteredAttendanceData.fold(
        0, (sum, course) => sum + (course['attended'] as int));
  }

  int get _totalMissedClasses {
    return _totalClasses - _totalAttendedClasses;
  }

  List<Map<String, dynamic>> get _filteredAttendanceData {
    return _attendanceData.where((course) {
      // Apply semester filter
      if (_currentFilters['semester'] != 'All' &&
          course['semester'] != _currentFilters['semester']) {
        return false;
      }

      // Apply course type filter
      if (_currentFilters['courseType'] != 'All' &&
          course['type'] != _currentFilters['courseType']) {
        return false;
      }

      // Apply status filter
      if (_currentFilters['status'] != 'All') {
        final percentage = (course['percentage'] as num).toDouble();
        switch (_currentFilters['status']) {
          case 'Excellent (≥75%)':
            if (percentage < 75) return false;
            break;
          case 'Warning (65-75%)':
            if (percentage < 65 || percentage >= 75) return false;
            break;
          case 'Critical (<65%)':
            if (percentage >= 65) return false;
            break;
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Tracker"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.appBarTheme.iconTheme?.color ??
                Colors.black,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _toggleFilters,
            icon: CustomIconWidget(
              iconName: 'filter_list',
              color: _showFilters
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.appBarTheme.iconTheme?.color ??
                      Colors.black,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: _refreshData,
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: AppTheme.lightTheme.appBarTheme.iconTheme?.color ??
                  Colors.black,
              size: 24,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: CustomIconWidget(
                iconName: 'list',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              text: "List View",
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'calendar_today',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              text: "Calendar",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_showFilters)
            FilterOptionsWidget(
              currentFilters: _currentFilters,
              onFiltersChanged: _onFiltersChanged,
            ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildListView(),
                _buildCalendarView(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Attendance tracker is at index 2
        onTap: _onBottomNavTap,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'home',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'notifications',
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'notifications',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'event_available',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'event_available',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'assignment',
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'assignment',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: Colors.grey,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'person',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          AttendanceOverviewCard(
            attendancePercentage: _overallAttendancePercentage,
            totalClasses: _totalClasses,
            attendedClasses: _totalAttendedClasses,
            missedClasses: _totalMissedClasses,
          ),
          PredictiveAnalyticsCard(
            currentPercentage: _overallAttendancePercentage,
            totalClasses: _totalClasses,
            attendedClasses: _totalAttendedClasses,
          ),
          QuickActionsWidget(
            onBulkMark: _showBulkMarkDialog,
            onAppealSubmit: _showAppealDialog,
            onExportData: _exportAttendanceData,
            onSyncData: _syncAttendanceData,
          ),
          SizedBox(height: 1.h),
          ..._filteredAttendanceData.map((courseData) {
            return CourseAttendanceCard(
              courseData: courseData,
              onTap: () => _showCourseDetails(courseData),
            );
          }).toList(),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          AttendanceOverviewCard(
            attendancePercentage: _overallAttendancePercentage,
            totalClasses: _totalClasses,
            attendedClasses: _totalAttendedClasses,
            missedClasses: _totalMissedClasses,
          ),
          CalendarViewWidget(
            attendanceData: _filteredAttendanceData,
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  void _onFiltersChanged(Map<String, dynamic> filters) {
    setState(() {
      _currentFilters = filters;
      _showFilters = false;
    });
  }

  void _refreshData() {
    // Simulate data refresh
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Attendance data refreshed successfully"),
        backgroundColor: AppTheme.getSuccessColor(true),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard-home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/smart-notifications-center');
        break;
      case 2:
        // Current screen - do nothing
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/assignment-tracker');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/user-profile-settings');
        break;
    }
  }

  void _showCourseDetails(Map<String, dynamic> courseData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 12.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                courseData['courseCode'] as String,
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                courseData['courseName'] as String,
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailCard(
                      "Attendance",
                      "${(courseData['percentage'] as num).toStringAsFixed(1)}%",
                      AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: _buildDetailCard(
                      "Classes",
                      "${courseData['attended']}/${courseData['total']}",
                      AppTheme.getSuccessColor(true),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                "Attendance History",
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: (courseData['records'] as List).length,
                  itemBuilder: (context, index) {
                    final record = (courseData['records'] as List)[index]
                        as Map<String, dynamic>;
                    return ListTile(
                      leading: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: record['status'] == 'Present'
                              ? AppTheme.getSuccessColor(true)
                              : AppTheme.getErrorColor(true),
                        ),
                      ),
                      title: Text(record['date'] as String),
                      subtitle: Text(record['topic'] as String),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: record['status'] == 'Present'
                              ? AppTheme.getSuccessColor(true)
                                  .withValues(alpha: 0.1)
                              : AppTheme.getErrorColor(true)
                                  .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          record['status'] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: record['status'] == 'Present'
                                ? AppTheme.getSuccessColor(true)
                                : AppTheme.getErrorColor(true),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
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
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showBulkMarkDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Bulk Mark Attendance"),
        content: Text(
            "This feature allows professors to mark attendance for multiple students at once. Contact your instructor for access."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showAppealDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Submit Attendance Appeal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contest incorrect attendance marking:"),
            SizedBox(height: 1.h),
            TextField(
              decoration: InputDecoration(
                hintText: "Describe the issue...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Appeal submitted successfully"),
                  backgroundColor: AppTheme.getSuccessColor(true),
                ),
              );
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _exportAttendanceData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Attendance report exported to Downloads"),
        backgroundColor: AppTheme.getSuccessColor(true),
        action: SnackBarAction(
          label: "View",
          onPressed: () {},
        ),
      ),
    );
  }

  void _syncAttendanceData() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Syncing with university systems..."),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );

    // Simulate sync delay
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data synchronized successfully"),
            backgroundColor: AppTheme.getSuccessColor(true),
          ),
        );
      }
    });
  }
}
