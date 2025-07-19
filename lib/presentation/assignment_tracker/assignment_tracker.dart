import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/assignment_list_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/quick_stats_widget.dart';
import './widgets/sort_dropdown_widget.dart';
import './widgets/workload_chart_widget.dart';

class AssignmentTracker extends StatefulWidget {
  const AssignmentTracker({Key? key}) : super(key: key);

  @override
  State<AssignmentTracker> createState() => _AssignmentTrackerState();
}

class _AssignmentTrackerState extends State<AssignmentTracker> {
  String _selectedCourse = 'All';
  String _selectedType = 'All';
  String _selectedStatus = 'All';
  String _selectedSort = 'Due Date';

  final List<String> _courses = [
    'All',
    'Computer Science',
    'Mathematics',
    'Physics',
    'Chemistry',
    'English Literature',
    'Business Studies',
  ];

  final List<String> _types = [
    'All',
    'Homework',
    'Project',
    'Exam',
    'Lab Report',
    'Essay',
    'Presentation',
  ];

  final List<String> _statuses = [
    'All',
    'Pending',
    'In Progress',
    'Completed',
    'Overdue',
  ];

  final List<Map<String, dynamic>> _assignments = [
    {
      "id": 1,
      "courseName": "Computer Science",
      "title": "Data Structures Implementation",
      "description":
          "Implement various data structures including linked lists, stacks, queues, and binary trees with comprehensive documentation.",
      "dueDate": DateTime.now().add(Duration(days: 3)),
      "priority": 3,
      "status": "in-progress",
      "progress": 0.65,
      "estimatedHours": 8,
      "type": "Project",
      "weightage": 25,
    },
    {
      "id": 2,
      "courseName": "Mathematics",
      "title": "Calculus Problem Set 5",
      "description":
          "Solve integration and differentiation problems covering chapters 12-15.",
      "dueDate": DateTime.now().add(Duration(days: 1)),
      "priority": 2,
      "status": "pending",
      "progress": 0.0,
      "estimatedHours": 4,
      "type": "Homework",
      "weightage": 15,
    },
    {
      "id": 3,
      "courseName": "Physics",
      "title": "Quantum Mechanics Lab Report",
      "description":
          "Analyze experimental data from quantum tunneling experiment and write comprehensive lab report.",
      "dueDate": DateTime.now().add(Duration(days: 7)),
      "priority": 2,
      "status": "pending",
      "progress": 0.2,
      "estimatedHours": 6,
      "type": "Lab Report",
      "weightage": 20,
    },
    {
      "id": 4,
      "courseName": "English Literature",
      "title": "Shakespeare Essay Analysis",
      "description":
          "Write a 2000-word essay analyzing themes in Hamlet with proper citations and references.",
      "dueDate": DateTime.now().subtract(Duration(days: 2)),
      "priority": 3,
      "status": "overdue",
      "progress": 0.8,
      "estimatedHours": 10,
      "type": "Essay",
      "weightage": 30,
    },
    {
      "id": 5,
      "courseName": "Chemistry",
      "title": "Organic Chemistry Midterm",
      "description":
          "Comprehensive exam covering organic reaction mechanisms and synthesis pathways.",
      "dueDate": DateTime.now().add(Duration(days: 5)),
      "priority": 3,
      "status": "pending",
      "progress": 0.4,
      "estimatedHours": 12,
      "type": "Exam",
      "weightage": 40,
    },
    {
      "id": 6,
      "courseName": "Business Studies",
      "title": "Marketing Strategy Presentation",
      "description":
          "Create and present a comprehensive marketing strategy for a startup company.",
      "dueDate": DateTime.now().add(Duration(days: 10)),
      "priority": 1,
      "status": "completed",
      "progress": 1.0,
      "estimatedHours": 8,
      "type": "Presentation",
      "weightage": 25,
    },
    {
      "id": 7,
      "courseName": "Computer Science",
      "title": "Algorithm Analysis Assignment",
      "description":
          "Analyze time and space complexity of various sorting and searching algorithms.",
      "dueDate": DateTime.now().add(Duration(days: 14)),
      "priority": 1,
      "status": "pending",
      "progress": 0.1,
      "estimatedHours": 5,
      "type": "Homework",
      "weightage": 15,
    },
    {
      "id": 8,
      "courseName": "Mathematics",
      "title": "Statistics Project",
      "description":
          "Conduct statistical analysis on real-world data set and present findings with visualizations.",
      "dueDate": DateTime.now().add(Duration(days: 12)),
      "priority": 2,
      "status": "in-progress",
      "progress": 0.3,
      "estimatedHours": 15,
      "type": "Project",
      "weightage": 35,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAssignments = _getFilteredAssignments();

    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Tracker'),
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'search',
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
            onPressed: () => _showOptionsMenu(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshAssignments,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              QuickStatsWidget(assignments: _assignments),
              SizedBox(height: 2.h),
              WorkloadChartWidget(assignments: _assignments),
              SizedBox(height: 2.h),
              FilterChipsWidget(
                selectedCourse: _selectedCourse,
                selectedType: _selectedType,
                selectedStatus: _selectedStatus,
                courses: _courses,
                types: _types,
                statuses: _statuses,
                onCourseChanged: (course) =>
                    setState(() => _selectedCourse = course),
                onTypeChanged: (type) => setState(() => _selectedType = type),
                onStatusChanged: (status) =>
                    setState(() => _selectedStatus = status),
                onClearFilters: _clearAllFilters,
              ),
              SizedBox(height: 2.h),
              SortDropdownWidget(
                selectedSort: _selectedSort,
                onSortChanged: (sort) => setState(() => _selectedSort = sort),
              ),
              SizedBox(height: 2.h),
              AssignmentListWidget(
                assignments: filteredAssignments,
                sortBy: _selectedSort,
                onAssignmentTap: _onAssignmentTap,
                onStatusUpdate: _onStatusUpdate,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAssignment,
        child: CustomIconWidget(
          iconName: 'add',
          color: Theme.of(context).colorScheme.onPrimary,
          size: 24,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        onTap: _onBottomNavTap,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor!,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'home',
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'notifications',
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor!,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'notifications',
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              size: 24,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'how_to_reg',
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor!,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'how_to_reg',
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              size: 24,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'assignment',
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              size: 24,
            ),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor!,
              size: 24,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'person',
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAssignments() {
    return _assignments.where((assignment) {
      final courseMatch = _selectedCourse == 'All' ||
          assignment['courseName'] == _selectedCourse;
      final typeMatch =
          _selectedType == 'All' || assignment['type'] == _selectedType;
      final statusMatch = _selectedStatus == 'All' ||
          _getDisplayStatus(assignment) == _selectedStatus;

      return courseMatch && typeMatch && statusMatch;
    }).toList();
  }

  String _getDisplayStatus(Map<String, dynamic> assignment) {
    final status = (assignment['status'] as String? ?? 'pending').toLowerCase();
    final dueDate = assignment['dueDate'] as DateTime? ?? DateTime.now();
    final now = DateTime.now();

    if (status == 'completed') return 'Completed';
    if (status == 'in-progress') return 'In Progress';
    if (dueDate.isBefore(now) && status != 'completed') return 'Overdue';
    return 'Pending';
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCourse = 'All';
      _selectedType = 'All';
      _selectedStatus = 'All';
    });
  }

  void _onAssignmentTap(Map<String, dynamic> assignment) {
    _showAssignmentDetails(assignment);
  }

  void _onStatusUpdate(Map<String, dynamic> assignment) {
    _showStatusUpdateDialog(assignment);
  }

  void _showAssignmentDetails(Map<String, dynamic> assignment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                  width: 10.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                assignment['title'] as String? ?? 'Untitled',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(height: 1.h),
              Text(
                assignment['courseName'] as String? ?? 'Unknown Course',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        assignment['description'] as String? ??
                            'No description available.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailItem(
                              context,
                              'Due Date',
                              _formatDate(assignment['dueDate'] as DateTime? ??
                                  DateTime.now()),
                              'schedule',
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: _buildDetailItem(
                              context,
                              'Priority',
                              _getPriorityText(
                                  assignment['priority'] as int? ?? 1),
                              'priority_high',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailItem(
                              context,
                              'Estimated Time',
                              '${assignment['estimatedHours'] as int? ?? 1}h',
                              'access_time',
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: _buildDetailItem(
                              context,
                              'Weightage',
                              '${assignment['weightage'] as int? ?? 0}%',
                              'percent',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _onStatusUpdate(assignment);
                      },
                      child: Text('Update Status'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context, String label, String value, String iconName) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: Theme.of(context).colorScheme.primary,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  void _showStatusUpdateDialog(Map<String, dynamic> assignment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Update status for "${assignment['title']}"'),
            SizedBox(height: 2.h),
            ...['Pending', 'In Progress', 'Completed']
                .map(
                  (status) => ListTile(
                    leading: CustomIconWidget(
                      iconName: _getStatusIconForDialog(status),
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    title: Text(status),
                    onTap: () {
                      Navigator.pop(context);
                      _updateAssignmentStatus(assignment,
                          status.toLowerCase().replaceAll(' ', '-'));
                    },
                  ),
                )
                .toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  String _getStatusIconForDialog(String status) {
    switch (status) {
      case 'Completed':
        return 'check_circle';
      case 'In Progress':
        return 'pending';
      default:
        return 'radio_button_unchecked';
    }
  }

  void _updateAssignmentStatus(
      Map<String, dynamic> assignment, String newStatus) {
    setState(() {
      final index = _assignments.indexWhere((a) => a['id'] == assignment['id']);
      if (index != -1) {
        _assignments[index]['status'] = newStatus;
        if (newStatus == 'completed') {
          _assignments[index]['progress'] = 1.0;
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Assignment status updated successfully'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Implement undo functionality
          },
        ),
      ),
    );
  }

  String _getPriorityText(int priority) {
    switch (priority) {
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      default:
        return 'Low';
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Assignments'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Enter assignment title or course name...',
            prefixIcon: CustomIconWidget(
              iconName: 'search',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
          onChanged: (value) {
            // Implement search functionality
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'file_download',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: Text('Export Assignments'),
              onTap: () {
                Navigator.pop(context);
                _exportAssignments();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'sync',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: Text('Sync with LMS'),
              onTap: () {
                Navigator.pop(context);
                _syncWithLMS();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'settings',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                _openSettings();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addNewAssignment() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add new assignment feature coming soon!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void _exportAssignments() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting assignments...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _syncWithLMS() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Syncing with LMS...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _openSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settings feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _refreshAssignments() async {
    await Future.delayed(Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Assignments refreshed'),
        duration: Duration(seconds: 1),
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
        Navigator.pushReplacementNamed(context, '/attendance-tracker');
        break;
      case 3:
        // Current screen
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/user-profile-settings');
        break;
    }
  }
}
