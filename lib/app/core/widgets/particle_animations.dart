import 'dart:math';
import 'package:flutter/material.dart';

class ParticleSystem extends StatefulWidget {
  final int numberOfParticles;
  final Color particleColor;
  final double maxRadius;
  final double minRadius;
  final Duration animationDuration;
  final Widget? child;

  const ParticleSystem({
    super.key,
    this.numberOfParticles = 20,
    this.particleColor = Colors.white,
    this.maxRadius = 3.0,
    this.minRadius = 1.0,
    this.animationDuration = const Duration(seconds: 10),
    this.child,
  });

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

// Create a persistent particle system that survives widget rebuilds
class PersistentParticleSystem extends StatefulWidget {
  final int numberOfParticles;
  final Color particleColor;
  final double maxRadius;
  final double minRadius;
  final Duration animationDuration;
  final Widget? child;

  const PersistentParticleSystem({
    super.key,
    this.numberOfParticles = 20,
    this.particleColor = Colors.white,
    this.maxRadius = 3.0,
    this.minRadius = 1.0,
    this.animationDuration = const Duration(seconds: 10),
    this.child,
  });

  @override
  State<PersistentParticleSystem> createState() => _PersistentParticleSystemState();
}

class _PersistentParticleSystemState extends State<PersistentParticleSystem>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late List<Particle> particles;
  final Random random = Random();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    particles = List.generate(widget.numberOfParticles, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        vx: (random.nextDouble() - 0.5) * 0.002,
        vy: (random.nextDouble() - 0.5) * 0.002,
        radius: widget.minRadius + 
               random.nextDouble() * (widget.maxRadius - widget.minRadius),
        opacity: 0.3 + random.nextDouble() * 0.7,
      );
    });

    _controller.addListener(_updateParticles);
    _controller.repeat();
  }

  void _updateParticles() {
    if (mounted) {
      setState(() {
        for (var particle in particles) {
          particle.x += particle.vx;
          particle.y += particle.vy;

          if (particle.x < 0 || particle.x > 1) {
            particle.vx = -particle.vx;
            particle.x = particle.x.clamp(0.0, 1.0);
          }
          if (particle.y < 0 || particle.y > 1) {
            particle.vy = -particle.vy;
            particle.y = particle.y.clamp(0.0, 1.0);
          }
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
    super.build(context);
    return Stack(
      children: [
        // Particles
        Positioned.fill(
          child: CustomPaint(
            painter: ParticlePainter(
              particles: particles,
              color: widget.particleColor,
            ),
          ),
        ),
        // Child content
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _ParticleSystemState extends State<ParticleSystem>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    particles = List.generate(widget.numberOfParticles, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        vx: (random.nextDouble() - 0.5) * 0.002,
        vy: (random.nextDouble() - 0.5) * 0.002,
        radius: widget.minRadius + 
               random.nextDouble() * (widget.maxRadius - widget.minRadius),
        opacity: 0.3 + random.nextDouble() * 0.7,
      );
    });

    _controller.addListener(_updateParticles);
    _controller.repeat();
  }

  void _updateParticles() {
    setState(() {
      for (var particle in particles) {
        particle.x += particle.vx;
        particle.y += particle.vy;

        if (particle.x < 0 || particle.x > 1) {
          particle.vx = -particle.vx;
          particle.x = particle.x.clamp(0.0, 1.0);
        }
        if (particle.y < 0 || particle.y > 1) {
          particle.vy = -particle.vy;
          particle.y = particle.y.clamp(0.0, 1.0);
        }
      }
    });
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
        // Particles
        Positioned.fill(
          child: CustomPaint(
            painter: ParticlePainter(
              particles: particles,
              color: widget.particleColor,
            ),
          ),
        ),
        // Child content
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      final position = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      paint.color = color.withOpacity(particle.opacity);
      canvas.drawCircle(position, particle.radius, paint);

      // Add glow effect
      paint.color = color.withOpacity(particle.opacity * 0.3);
      canvas.drawCircle(position, particle.radius * 2, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return oldDelegate.particles != particles;
  }
}

class LiquidAnimation extends StatefulWidget {
  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final Duration duration;

  const LiquidAnimation({
    super.key,
    required this.child,
    this.primaryColor = const Color(0xFFFF6B9D),
    this.secondaryColor = const Color(0xFF00E5FF),
    this.duration = const Duration(seconds: 8),
  });

  @override
  State<LiquidAnimation> createState() => _LiquidAnimationState();
}

class _LiquidAnimationState extends State<LiquidAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _controller.repeat();
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
        // Animated background
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: LiquidPainter(
                  animationValue: _controller.value,
                  primaryColor: widget.primaryColor,
                  secondaryColor: widget.secondaryColor,
                ),
              );
            },
          ),
        ),
        // Child content
        widget.child,
      ],
    );
  }
}

class LiquidPainter extends CustomPainter {
  final double animationValue;
  final Color primaryColor;
  final Color secondaryColor;

  LiquidPainter({
    required this.animationValue,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final path1 = Path();
    final path2 = Path();

    // Create liquid wave paths
    final waveHeight = size.height * 0.3;
    final waveSpeed = animationValue * 2 * pi;

    // First wave
    path1.moveTo(0, size.height * 0.7);
    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height * 0.7 + 
                sin((x / size.width * 2 * pi) + waveSpeed) * waveHeight * 0.3;
      path1.lineTo(x, y);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    // Second wave
    path2.moveTo(0, size.height * 0.8);
    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height * 0.8 + 
                sin((x / size.width * 2 * pi) + waveSpeed + pi) * waveHeight * 0.2;
      path2.lineTo(x, y);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    // Paint the waves
    paint.color = primaryColor.withOpacity(0.1);
    canvas.drawPath(path1, paint);

    paint.color = secondaryColor.withOpacity(0.1);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(LiquidPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class GlowEffect extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;
  final Duration duration;

  const GlowEffect({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFFFF6B9D),
    this.glowRadius = 20.0,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<GlowEffect> createState() => _GlowEffectState();
}

class _GlowEffectState extends State<GlowEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
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
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(_glowAnimation.value * 0.6),
                blurRadius: widget.glowRadius * _glowAnimation.value,
                spreadRadius: widget.glowRadius * 0.3 * _glowAnimation.value,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}