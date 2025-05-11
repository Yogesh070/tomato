import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tomato/provider/pomodoro.dart';

class FullScreenTimer extends StatefulWidget {
  final TimerMode mode;
  final int secondsRemaining;
  final int totalSeconds;
  final VoidCallback onExit;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final bool isRunning;

  const FullScreenTimer({
    super.key,
    required this.mode,
    required this.secondsRemaining,
    required this.totalSeconds,
    required this.onExit,
    required this.onPause,
    required this.onResume,
    required this.isRunning,
  });

  @override
  State<FullScreenTimer> createState() => _FullScreenTimerState();
}

class _FullScreenTimerState extends State<FullScreenTimer>
    with TickerProviderStateMixin {
  bool _isHolding = false;
  double _holdProgress = 0.0;
  late AnimationController _progressController;

  // Track our own animation for the circular timer
  late AnimationController _timerAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTimerAnimation();
  }

  @override
  void initState() {
    super.initState();
    // Create the hold progress controller for exit action
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _progressController.addListener(() {
      setState(() {
        _holdProgress = _progressController.value;
      });

      if (_progressController.isCompleted) {
        _cancelHold();
        widget.onExit();
      }
    });

    // Create timer animation controller
    _timerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.totalSeconds),
    );

    _updateTimerAnimation();
  }

  void _updateTimerAnimation() {
    if (widget.isRunning) {
      _timerAnimationController.duration = Duration(
        seconds: widget.totalSeconds,
      );
      _timerAnimationController.value =
          1.0 - (widget.secondsRemaining / widget.totalSeconds);
    } else {
      _timerAnimationController.stop();
    }
  }

  @override
  void didUpdateWidget(FullScreenTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update the timer animation when props change
    if (oldWidget.secondsRemaining != widget.secondsRemaining ||
        oldWidget.totalSeconds != widget.totalSeconds ||
        oldWidget.isRunning != widget.isRunning) {
      _updateTimerAnimation();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _timerAnimationController.dispose();
    super.dispose();
  }

  void _startHold() {
    if (_isHolding) return;

    setState(() {
      _isHolding = true;
    });

    // Start the hold progress animation
    _progressController.forward(from: 0.0);

    // Add haptic feedback
    HapticFeedback.lightImpact();
  }

  void _cancelHold() {
    if (!_isHolding) return;

    setState(() {
      _isHolding = false;
      _holdProgress = 0.0;
    });

    _progressController.stop();
    _progressController.reset();

    // Add haptic feedback when hold is canceled
    HapticFeedback.lightImpact();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Color _getModeColor(TimerMode mode) {
    switch (mode) {
      case TimerMode.work:
        return Colors.red;
      case TimerMode.shortBreak:
        return Colors.green;
      case TimerMode.longBreak:
        return Colors.blue;
    }
  }

  String _getModeText(TimerMode mode) {
    switch (mode) {
      case TimerMode.work:
        return "Work";
      case TimerMode.shortBreak:
        return "Short Break";
      case TimerMode.longBreak:
        return "Long Break";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color modeColor = _getModeColor(widget.mode);
    final timerProgress = widget.secondsRemaining / widget.totalSeconds;
    final screenSize = MediaQuery.of(context).size;

    final timerSize = _calculateResponsiveTimerSize(screenSize);

    return GestureDetector(
      onLongPressStart: (_) => _startHold(),
      onLongPressEnd: (_) => _cancelHold(),
      onTap: () {
        if (widget.isRunning) {
          widget.onPause();
        } else {
          widget.onResume();
        }
        HapticFeedback.selectionClick();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: timerSize,
                    height: timerSize,
                    child: CircularProgressIndicator(
                      value: 1 - timerProgress,
                      strokeWidth: timerSize * 0.0125,
                      backgroundColor: modeColor.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(modeColor),
                    ),
                  ),

                  // Timer text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(widget.secondsRemaining),
                        style: TextStyle(
                          fontSize: timerSize * 0.25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _getModeText(widget.mode),
                        style: TextStyle(
                          fontSize: timerSize * 0.056,
                          color: modeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Play/pause indicator
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.isRunning ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.isRunning ? "Tap to pause" : "Tap to resume",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),

              const Spacer(),

              // Hold to exit indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    Text(
                      _isHolding
                          ? "Keep holding to exit..."
                          : "Hold for 3 seconds to exit",
                      style: TextStyle(
                        color: _isHolding ? modeColor : Colors.white54,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80.0),
                      child: Stack(
                        children: [
                          // Background bar (always visible)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 4,
                              width: double.infinity,
                              color: Colors.grey.shade800,
                            ),
                          ),

                          // Progress bar (only visible when holding)
                          if (_isHolding)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                height: 4,
                                width:
                                    (MediaQuery.of(context).size.width - 160) *
                                    _holdProgress,
                                color: modeColor,
                              ),
                            ),
                        ],
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

  double _calculateResponsiveTimerSize(Size screenSize) {
    final smallerDimension =
        screenSize.width < screenSize.height
            ? screenSize.width
            : screenSize.height;

    // On small to medium screens, use 80% of the smaller dimension
    double baseSize = smallerDimension * 0.8;

    final maxSize = 400.0;

    return baseSize > maxSize ? maxSize : baseSize;
  }
}
