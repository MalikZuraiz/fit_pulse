import 'dart:math';
import 'package:flutter/material.dart';

class ContinuousParticleOverlay extends StatefulWidget {
  final Widget child;
  final int numberOfParticles;
  final List<Color> particleColors;
  final double maxRadius;
  final double minRadius;

  const ContinuousParticleOverlay({
    super.key,
    required this.child,
    this.numberOfParticles = 20,
    this.particleColors = const [
      Color(0x4DFF6B9D), // Pink
      Color(0x4D00E5FF), // Cyan
      Color(0x3DFFFF00), // Yellow
    ],
    this.maxRadius = 3.0,
    this.minRadius = 1.0,
  });

  @override
  State<ContinuousParticleOverlay> createState() => _ContinuousParticleOverlayState();
}

class _ContinuousParticleOverlayState extends State<ContinuousParticleOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<ContinuousParticle> particles;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    
    // Use a very long duration and repeat forever
    _controller = AnimationController(
      duration: const Duration(minutes: 10), // Very long duration
      vsync: this,
    );

    _initializeParticles();
    
    // Start the animation and keep it running
    _controller.addListener(_updateParticles);
    _controller.repeat();
  }

  void _initializeParticles() {
    particles = List.generate(widget.numberOfParticles, (index) {
      return ContinuousParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        vx: (random.nextDouble() - 0.5) * 0.001, // Slower movement
        vy: (random.nextDouble() - 0.5) * 0.001,
        radius: widget.minRadius + 
               random.nextDouble() * (widget.maxRadius - widget.minRadius),
        opacity: 0.2 + random.nextDouble() * 0.6,
        color: widget.particleColors[random.nextInt(widget.particleColors.length)],
        rotationSpeed: (random.nextDouble() - 0.5) * 0.02,
        pulseFactor: 0.8 + random.nextDouble() * 0.4,
      );
    });
  }

  void _updateParticles() {
    if (mounted) {
      setState(() {
        for (var particle in particles) {
          // Update position
          particle.x += particle.vx;
          particle.y += particle.vy;

          // Bounce off walls
          if (particle.x < 0 || particle.x > 1) {
            particle.vx = -particle.vx;
            particle.x = particle.x.clamp(0.0, 1.0);
          }
          if (particle.y < 0 || particle.y > 1) {
            particle.vy = -particle.vy;
            particle.y = particle.y.clamp(0.0, 1.0);
          }

          // Update rotation
          particle.rotation += particle.rotationSpeed;

          // Update pulse
          particle.pulseTime += 0.05;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Particle overlay (background layer)
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true, // Explicitly ignore all pointer events
            child: CustomPaint(
              painter: ContinuousParticlePainter(
                particles: particles,
              ),
            ),
          ),
        ),
        // Child content (foreground layer)
        widget.child,
      ],
    );
  }
}

class ContinuousParticle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;
  Color color;
  double rotation;
  double rotationSpeed;
  double pulseTime;
  double pulseFactor;

  ContinuousParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
    required this.color,
    required this.rotationSpeed,
    required this.pulseFactor,
    this.rotation = 0.0,
    this.pulseTime = 0.0,
  });

  double get currentRadius => radius * (1.0 + sin(pulseTime) * 0.3 * pulseFactor);
  double get currentOpacity => opacity * (0.7 + sin(pulseTime * 0.5) * 0.3 * pulseFactor);
}

class ContinuousParticlePainter extends CustomPainter {
  final List<ContinuousParticle> particles;

  ContinuousParticlePainter({
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      final position = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      // Draw particle with glow effect
      final currentRadius = particle.currentRadius;
      final currentOpacity = particle.currentOpacity;

      // Main particle
      paint.color = particle.color.withOpacity(currentOpacity);
      canvas.drawCircle(position, currentRadius, paint);

      // Glow effect
      paint.color = particle.color.withOpacity(currentOpacity * 0.3);
      canvas.drawCircle(position, currentRadius * 2, paint);

      // Additional subtle glow
      paint.color = particle.color.withOpacity(currentOpacity * 0.1);
      canvas.drawCircle(position, currentRadius * 3, paint);
    }
  }

  @override
  bool shouldRepaint(ContinuousParticlePainter oldDelegate) {
    return true; // Always repaint for continuous animation
  }
}

// Simple floating widget that doesn't interfere with other animations
class SimpleFloating extends StatefulWidget {
  final Widget child;
  final double amplitude;
  final Duration duration;

  const SimpleFloating({
    super.key,
    required this.child,
    this.amplitude = 5.0,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<SimpleFloating> createState() => _SimpleFloatingState();
}

class _SimpleFloatingState extends State<SimpleFloating>
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
      begin: -widget.amplitude,
      end: widget.amplitude,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

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