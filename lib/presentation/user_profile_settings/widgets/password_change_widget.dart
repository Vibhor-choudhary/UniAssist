import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PasswordChangeWidget extends StatefulWidget {
  const PasswordChangeWidget({Key? key}) : super(key: key);

  @override
  State<PasswordChangeWidget> createState() => _PasswordChangeWidgetState();
}

class _PasswordChangeWidgetState extends State<PasswordChangeWidget> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // Password strength indicators
  int _passwordStrength = 0;
  List<String> _strengthCriteria = [];

  void _checkPasswordStrength(String password) {
    setState(() {
      _passwordStrength = 0;
      _strengthCriteria.clear();

      if (password.length >= 8) {
        _passwordStrength++;
        _strengthCriteria.add('At least 8 characters');
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        _passwordStrength++;
        _strengthCriteria.add('Contains uppercase letter');
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        _passwordStrength++;
        _strengthCriteria.add('Contains lowercase letter');
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        _passwordStrength++;
        _strengthCriteria.add('Contains number');
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        _passwordStrength++;
        _strengthCriteria.add('Contains special character');
      }
    });
  }

  Color _getStrengthColor() {
    switch (_passwordStrength) {
      case 0:
      case 1:
        return AppTheme.lightTheme.colorScheme.error;
      case 2:
      case 3:
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 4:
      case 5:
        return AppTheme.lightTheme.colorScheme.primary;
      default:
        return AppTheme.lightTheme.colorScheme.error;
    }
  }

  String _getStrengthText() {
    switch (_passwordStrength) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
      case 3:
        return 'Medium';
      case 4:
      case 5:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() => _isLoading = false);

      // Clear form
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'lock',
                    size: 6.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Change Password',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Current Password
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'lock_outline',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: CustomIconWidget(
                      iconName: _obscureCurrentPassword
                          ? 'visibility'
                          : 'visibility_off',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      setState(() =>
                          _obscureCurrentPassword = !_obscureCurrentPassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  // Mock validation - in real app, verify with server
                  if (value != 'currentPassword123') {
                    return 'Current password is incorrect';
                  }
                  return null;
                },
              ),

              SizedBox(height: 2.h),

              // New Password
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                onChanged: _checkPasswordStrength,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'lock',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: CustomIconWidget(
                      iconName:
                          _obscureNewPassword ? 'visibility' : 'visibility_off',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      setState(
                          () => _obscureNewPassword = !_obscureNewPassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (value == _currentPasswordController.text) {
                    return 'New password must be different from current password';
                  }
                  return null;
                },
              ),

              // Password Strength Indicator
              if (_newPasswordController.text.isNotEmpty) ...[
                SizedBox(height: 2.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Password Strength: ',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                        Text(
                          _getStrengthText(),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: _getStrengthColor(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    LinearProgressIndicator(
                      value: _passwordStrength / 5,
                      backgroundColor: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_getStrengthColor()),
                    ),
                    SizedBox(height: 1.h),
                    Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: _strengthCriteria.map((criteria) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconWidget(
                                iconName: 'check',
                                size: 3.w,
                                color: AppTheme.lightTheme.colorScheme.primary,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                criteria,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 2.h),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'lock',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: CustomIconWidget(
                      iconName: _obscureConfirmPassword
                          ? 'visibility'
                          : 'visibility_off',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    onPressed: () {
                      setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              SizedBox(height: 4.h),

              // Change Password Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _changePassword,
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
                      : Text('Change Password'),
                ),
              ),

              SizedBox(height: 2.h),

              // Security Tips
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'security',
                          size: 4.w,
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Security Tips',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      '• Use a unique password for your account\n'
                      '• Include uppercase, lowercase, numbers, and symbols\n'
                      '• Avoid using personal information\n'
                      '• Change your password regularly',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
