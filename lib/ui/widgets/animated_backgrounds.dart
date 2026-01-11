import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

/// Animated gradient background widget
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
    this.colors = const [
      Color(0xFF0F2027),
      Color(0xFF203A43),
      Color(0xFF2C5364),
    ],
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);

    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_controller);
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
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: _topAlignmentAnimation.value,
              end: _bottomAlignmentAnimation.value,
              colors: widget.colors,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Floating decorative shapes
class FloatingShapes extends StatefulWidget {
  final int numberOfShapes;
  final Color? color;

  const FloatingShapes({super.key, this.numberOfShapes = 5, this.color});

  @override
  State<FloatingShapes> createState() => _FloatingShapesState();
}

class _FloatingShapesState extends State<FloatingShapes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
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
        return Stack(
          children: List.generate(
            widget.numberOfShapes,
            (index) => _buildFloatingShape(index),
          ),
        );
      },
    );
  }

  Widget _buildFloatingShape(int index) {
    final size = 50.0 + (index * 30.0);
    final offset = _controller.value * 2 * 3.14159;
    final x =
        MediaQuery.of(context).size.width *
        (0.1 + (index * 0.2) + (0.05 * (index % 2 == 0 ? 1 : -1)));
    final y =
        MediaQuery.of(context).size.height * 0.5 +
        (100 * (index % 2 == 0 ? 1 : -1) * (1 + offset));

    return Positioned(
      left: x,
      top: y,
      child: Opacity(
        opacity: 0.1,
        child: Transform.rotate(
          angle: offset + (index * 0.5),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: index % 2 == 0 ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: index % 2 != 0 ? BorderRadius.circular(20) : null,
              border: Border.all(
                color: widget.color ?? AppColors.primaryBlue,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading effect
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const ShimmerLoading({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFFEBEBEB),
                Color(0xFFF4F4F4),
                Color(0xFFEBEBEB),
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
