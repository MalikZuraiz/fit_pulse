import 'package:flutter/material.dart';

class TabContentTransition extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final Duration duration;

  const TabContentTransition({
    super.key,
    required this.child,
    required this.currentIndex,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<TabContentTransition> createState() => _TabContentTransitionState();
}

class _TabContentTransitionState extends State<TabContentTransition>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _rotationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));

    // Start initial animation
    _slideController.forward();
    _scaleController.forward();
    _rotationController.forward();
  }

  @override
  void didUpdateWidget(TabContentTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateTabChange();
    }
  }

  void _animateTabChange() {
    // Determine slide direction based on tab index change
    final isForward = widget.currentIndex > _previousIndex;
    
    _slideAnimation = Tween<Offset>(
      begin: isForward ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Reset and start animations
    _slideController.reset();
    _scaleController.reset();
    _rotationController.reset();
    
    _slideController.forward();
    _scaleController.forward();
    _rotationController.forward();
    
    _previousIndex = widget.currentIndex;
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _slideController,
        _scaleController,
        _rotationController,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CubeTransition extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Axis axis;

  const CubeTransition({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 600),
    this.axis = Axis.horizontal,
  });

  @override
  State<CubeTransition> createState() => _CubeTransitionState();
}

class _CubeTransitionState extends State<CubeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: widget.isVisible ? 0.0 : 1.57, // 90 degrees in radians
      end: widget.isVisible ? 1.57 : 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CubeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final rotationValue = _rotationAnimation.value;
        final scaleValue = _scaleAnimation.value;
        
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..scale(scaleValue)
            ..rotateY(widget.axis == Axis.horizontal ? rotationValue : 0.0)
            ..rotateX(widget.axis == Axis.vertical ? rotationValue : 0.0),
          child: Opacity(
            opacity: rotationValue < 0.785 ? 1.0 : 0.0, // Hide when rotated 45 degrees
            child: widget.child,
          ),
        );
      },
    );
  }
}

class FlipTransition extends StatefulWidget {
  final Widget frontChild;
  final Widget backChild;
  final bool showFront;
  final Duration duration;
  final Axis flipAxis;

  const FlipTransition({
    super.key,
    required this.frontChild,
    required this.backChild,
    required this.showFront,
    this.duration = const Duration(milliseconds: 600),
    this.flipAxis = Axis.horizontal,
  });

  @override
  State<FlipTransition> createState() => _FlipTransitionState();
}

class _FlipTransitionState extends State<FlipTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (!widget.showFront) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FlipTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.showFront != widget.showFront) {
      if (widget.showFront) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final isShowingFront = _animation.value < 0.5;
        
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(widget.flipAxis == Axis.horizontal ? _animation.value * 3.14159 : 0.0)
            ..rotateX(widget.flipAxis == Axis.vertical ? _animation.value * 3.14159 : 0.0),
          child: isShowingFront
              ? widget.frontChild
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateY(widget.flipAxis == Axis.horizontal ? 3.14159 : 0.0)
                    ..rotateX(widget.flipAxis == Axis.vertical ? 3.14159 : 0.0),
                  child: widget.backChild,
                ),
        );
      },
    );
  }
}

class MorphTransition extends StatefulWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final double morphFactor;

  const MorphTransition({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 800),
    this.morphFactor = 0.1,
  });

  @override
  State<MorphTransition> createState() => _MorphTransitionState();
}

class _MorphTransitionState extends State<MorphTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _skewAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _skewAnimation = Tween<double>(
      begin: widget.morphFactor,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
    ));

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(MorphTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(_scaleAnimation.value)
            ..setEntry(0, 1, _skewAnimation.value), // Skew X
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}