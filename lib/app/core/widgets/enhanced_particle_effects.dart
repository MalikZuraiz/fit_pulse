import 'dart:math';
import 'package:flutter/material.dart';

class TabChangeParticleEffect extends StatefulWidget {
  final int currentIndex;
  final Color particleColor;
  final Widget child;

  const TabChangeParticleEffect({
    super.key,
    required this.currentIndex,
    required this.particleColor,
    required this.child,
  });

  @override
  State<TabChangeParticleEffect> createState() => _TabChangeParticleEffectState();
}

class _TabChangeParticleEffectState extends State<TabChangeParticleEffect>
    with TickerProviderStateMixin {
  late AnimationController _burstController;
  late List<BurstParticle> burstParticles;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    
    _burstController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    burstParticles = [];
  }

  @override
  void didUpdateWidget(TabChangeParticleEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.currentIndex != widget.currentIndex) {
      _triggerBurst();
    }
  }

  void _triggerBurst() {
    burstParticles.clear();
    
    // Create burst particles
    for (int i = 0; i < 12; i++) {
      final angle = (i / 12) * 2 * pi;
      final speed = 0.3 + random.nextDouble() * 0.4;
      
      burstParticles.add(BurstParticle(
        startX: 0.5,
        startY: 0.8, // Near bottom where nav bar is
        velocityX: cos(angle) * speed,
        velocityY: sin(angle) * speed,
        size: 2.0 + random.nextDouble() * 3.0,
        life: 1.0,
        color: widget.particleColor,
      ));
    }
    
    _burstController.forward(from: 0);
  }

  @override
  void dispose() {
    _burstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Burst particles overlay
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true, // Ignore all pointer events
            child: AnimatedBuilder(
              animation: _burstController,
              builder: (context, child) {
                return CustomPaint(
                  painter: BurstParticlePainter(
                    particles: burstParticles,
                    animationValue: _burstController.value,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BurstParticle {
  final double startX;
  final double startY;
  final double velocityX;
  final double velocityY;
  final double size;
  double life;
  final Color color;

  BurstParticle({
    required this.startX,
    required this.startY,
    required this.velocityX,
    required this.velocityY,
    required this.size,
    required this.life,
    required this.color,
  });

  void update(double progress) {
    life = 1.0 - progress;
  }

  double currentX(double progress) => startX + velocityX * progress;
  double currentY(double progress) => startY + velocityY * progress;
}

class BurstParticlePainter extends CustomPainter {
  final List<BurstParticle> particles;
  final double animationValue;

  BurstParticlePainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      particle.update(animationValue);
      
      if (particle.life > 0) {
        final position = Offset(
          particle.currentX(animationValue) * size.width,
          particle.currentY(animationValue) * size.height,
        );

        final opacity = (particle.life * (1.0 - animationValue)).clamp(0.0, 1.0);
        paint.color = particle.color.withOpacity(opacity);
        
        canvas.drawCircle(position, particle.size * particle.life, paint);
        
        // Add glow effect
        paint.color = particle.color.withOpacity(opacity * 0.3);
        canvas.drawCircle(position, particle.size * particle.life * 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BurstParticlePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// Enhanced floating animation that varies speed randomly
class VariableFloatingAnimation extends StatefulWidget {
  final Widget child;
  final Duration baseDuration;
  final double baseAmplitude;
  final bool autoStart;

  const VariableFloatingAnimation({
    super.key,
    required this.child,
    this.baseDuration = const Duration(seconds: 3),
    this.baseAmplitude = 10.0,
    this.autoStart = true,
  });

  @override
  State<VariableFloatingAnimation> createState() => _VariableFloatingAnimationState();
}

class _VariableFloatingAnimationState extends State<VariableFloatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random random = Random();
  late double actualAmplitude;
  late Duration actualDuration;

  @override
  void initState() {
    super.initState();
    
    // Randomize the amplitude and duration slightly
    actualAmplitude = widget.baseAmplitude * (0.7 + random.nextDouble() * 0.6);
    actualDuration = Duration(
      milliseconds: (widget.baseDuration.inMilliseconds * (0.8 + random.nextDouble() * 0.4)).round(),
    );
    
    _controller = AnimationController(
      duration: actualDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -actualAmplitude,
      end: actualAmplitude,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.repeat(reverse: true);
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
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: widget.child,
        );
      },
    );
  }
}