import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/login_footer_widget.dart';
import './widgets/login_form_widget.dart';
import './widgets/lpu_branding_widget.dart';
import './widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Mock credentials for different user types
  final List<Map<String, dynamic>> mockCredentials = [
    {
      "email": "rajesh.student@lpu.in",
      "password": "student123",
      "userType": "student",
      "name": "Rajesh Kumar"
    },
    {
      "email": "priya.mba@lpu.in",
      "password": "mba2024",
      "userType": "student",
      "name": "Priya Sharma"
    },
    {
      "email": "arjun.first@lpu.in",
      "password": "newbie123",
      "userType": "student",
      "name": "Arjun Singh"
    },
    {
      "email": "admin@lpu.in",
      "password": "admin123",
      "userType": "admin",
      "name": "LPU Administrator"
    }
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    // Simulate authentication delay
    await Future.delayed(Duration(milliseconds: 1500));

    // Check against mock credentials
    final validCredential = mockCredentials
        .any((cred) => cred["email"] == email && cred["password"] == password);

    if (validCredential) {
      final userCred = mockCredentials.firstWhere(
          (cred) => cred["email"] == email && cred["password"] == password);

      Fluttertoast.showToast(
        msg: "Welcome back, ${userCred["name"]}! 🎓",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        textColor: AppTheme.lightTheme.colorScheme.onPrimary,
      );

      // Navigate to dashboard
      Navigator.pushReplacementNamed(context, '/dashboard-home');
    } else {
      Fluttertoast.showToast(
        msg:
            "Invalid credentials. Please try: rajesh.student@lpu.in / student123",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        textColor: AppTheme.lightTheme.colorScheme.onError,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _handleSocialLogin(String provider) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 1000));

    String message = '';
    switch (provider) {
      case 'google':
        message = 'Google authentication successful! 🚀';
        break;
      case 'microsoft':
        message = 'Microsoft authentication successful! 💼';
        break;
      case 'lpu':
        message = 'LPU system authentication successful! 🎓';
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      textColor: AppTheme.lightTheme.colorScheme.onPrimary,
    );

    Navigator.pushReplacementNamed(context, '/dashboard-home');

    setState(() {
      _isLoading = false;
    });
  }

  void _handleForgotPassword() {
    Fluttertoast.showToast(
      msg: "Password reset link sent to your email! 📧",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
      textColor: AppTheme.lightTheme.colorScheme.onSecondary,
    );
  }

  void _handleCreateAccount() {
    Fluttertoast.showToast(
      msg: "Redirecting to registration portal... 📝",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
      textColor: AppTheme.lightTheme.colorScheme.onSecondary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.lightTheme.scaffoldBackgroundColor,
                AppTheme.lightTheme.colorScheme.secondary
                    .withValues(alpha: 0.02),
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.h),

                        // LPU Branding Section
                        LpuBrandingWidget(),

                        SizedBox(height: 4.h),

                        // Login Form Section
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.colorScheme.shadow,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Login Form
                              LoginFormWidget(
                                onLogin: _handleLogin,
                                isLoading: _isLoading,
                              ),

                              SizedBox(height: 4.h),

                              // Social Login Options
                              SocialLoginWidget(
                                onSocialLogin: _handleSocialLogin,
                                isLoading: _isLoading,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Footer Section
                        LoginFooterWidget(
                          onForgotPassword: _handleForgotPassword,
                          onCreateAccount: _handleCreateAccount,
                        ),

                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
