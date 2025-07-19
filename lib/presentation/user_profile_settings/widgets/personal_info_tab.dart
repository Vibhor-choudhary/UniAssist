import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PersonalInfoTab extends StatefulWidget {
  const PersonalInfoTab({Key? key}) : super(key: key);

  @override
  State<PersonalInfoTab> createState() => _PersonalInfoTabState();
}

class _PersonalInfoTabState extends State<PersonalInfoTab> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();

  String? _profileImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Mock user data
    _nameController.text = "Rajesh Kumar";
    _emailController.text = "rajesh.kumar@lpu.co.in";
    _phoneController.text = "+91 9876543210";
    _emergencyContactController.text = "Sunita Kumar (Mother)";
    _emergencyPhoneController.text = "+91 9876543211";
    _profileImageUrl =
        "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png";
  }

  Future<void> _selectProfileImage() async {
    // Mock image selection
    setState(() {
      _profileImageUrl =
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png";
    });
  }

  Future<void> _savePersonalInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Personal information updated successfully'),
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Photo Section
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _selectProfileImage,
                    child: Container(
                      width: 25.w,
                      height: 25.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: _profileImageUrl != null
                            ? CustomImageWidget(
                                imageUrl: _profileImageUrl!,
                                width: 25.w,
                                height: 25.w,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: AppTheme.lightTheme.colorScheme.surface,
                                child: CustomIconWidget(
                                  iconName: 'person',
                                  size: 12.w,
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextButton.icon(
                    onPressed: _selectProfileImage,
                    icon: CustomIconWidget(
                      iconName: 'camera_alt',
                      size: 4.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                    label: Text(
                      'Change Photo',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // Personal Information Fields
            Text(
              'Personal Information',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),

            // Full Name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'person',
                    size: 5.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'email',
                    size: 5.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),

            // Phone Number
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'phone',
                    size: 5.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),

            SizedBox(height: 4.h),

            // Emergency Contact Section
            Text(
              'Emergency Contact',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),

            // Emergency Contact Name
            TextFormField(
              controller: _emergencyContactController,
              decoration: InputDecoration(
                labelText: 'Emergency Contact Name',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'contact_emergency',
                    size: 5.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter emergency contact name';
                }
                return null;
              },
            ),
            SizedBox(height: 2.h),

            // Emergency Contact Phone
            TextFormField(
              controller: _emergencyPhoneController,
              decoration: InputDecoration(
                labelText: 'Emergency Contact Phone',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'phone',
                    size: 5.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter emergency contact phone';
                }
                return null;
              },
            ),

            SizedBox(height: 4.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _savePersonalInfo,
                child: _isLoading
                    ? SizedBox(
                        height: 5.w,
                        width: 5.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.lightTheme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    _emergencyPhoneController.dispose();
    super.dispose();
  }
}
