import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VoiceAiButtonWidget extends StatefulWidget {
  final VoidCallback? onPressed;

  const VoiceAiButtonWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  State<VoiceAiButtonWidget> createState() => _VoiceAiButtonWidgetState();
}

class _VoiceAiButtonWidgetState extends State<VoiceAiButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      _animationController.repeat(reverse: true);
      _startVoiceRecognition();
    } else {
      _animationController.stop();
      _stopVoiceRecognition();
    }
  }

  void _startVoiceRecognition() {
    // Simulate voice recognition start
    // In real implementation, this would start speech recognition
    Future.delayed(Duration(seconds: 3), () {
      if (mounted && _isListening) {
        _showVoiceResponse();
        _toggleListening();
      }
    });
  }

  void _stopVoiceRecognition() {
    // Stop voice recognition
  }

  void _showVoiceResponse() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'psychology',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Campus Copilot',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                'You said: "What\'s my attendance status?"',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Your overall attendance is 75.3%. Computer Networks needs attention at 72%. Would you like me to show your detailed attendance report?',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'No, thanks',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/attendance-tracker');
                  },
                  child: Text('Show Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      right: 5.w,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isListening ? _pulseAnimation.value : 1.0,
            child: FloatingActionButton(
              onPressed: widget.onPressed ?? _toggleListening,
              backgroundColor: _isListening
                  ? AppTheme.getErrorColor(true)
                  : AppTheme.lightTheme.primaryColor,
              elevation: _isListening ? 8 : 6,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _isListening
                    ? Column(
                        key: ValueKey('listening'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'mic',
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(height: 2),
                          Container(
                            width: 20,
                            height: 2,
                            child: LinearProgressIndicator(
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.3),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ],
                      )
                    : CustomIconWidget(
                        key: ValueKey('idle'),
                        iconName: 'psychology',
                        color: Colors.white,
                        size: 28,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
