import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

/// Beautiful section header with animated underline
class SectionHeader extends StatefulWidget {
  final String title;
  final String? subtitle;
  final TextAlign alignment;
  final Color? accentColor;
  final bool showUnderline;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = TextAlign.center,
    this.accentColor,
    this.showUnderline = true,
  });

  @override
  State<SectionHeader> createState() => _SectionHeaderState();
}

class _SectionHeaderState extends State<SectionHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _widthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = widget.accentColor ?? AppColors.accentOrange;

    return Column(
      crossAxisAlignment: widget.alignment == TextAlign.center
          ? CrossAxisAlignment.center
          : widget.alignment == TextAlign.right
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [effectiveColor, AppColors.primaryBlue],
            ).createShader(bounds);
          },
          child: Text(
            widget.title,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            textAlign: widget.alignment,
          ),
        ),
        if (widget.showUnderline) ...[
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return Container(
                height: 4,
                width: 80 * _widthAnimation.value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [effectiveColor, effectiveColor.withOpacity(0.5)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          ),
        ],
        if (widget.subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            widget.subtitle!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.mediumText,
              fontWeight: FontWeight.normal,
            ),
            textAlign: widget.alignment,
          ),
        ],
      ],
    );
  }
}

/// Gradient text widget
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.gradient = AppColors.accentGradient,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: (style ?? const TextStyle()).copyWith(color: AppColors.white),
        textAlign: textAlign,
      ),
    );
  }
}

/// Animated number counter
class AnimatedCounter extends StatefulWidget {
  final int end;
  final int start;
  final Duration duration;
  final TextStyle? style;
  final String? suffix;
  final String? prefix;

  const AnimatedCounter({
    super.key,
    required this.end,
    this.start = 0,
    this.duration = const Duration(seconds: 2),
    this.style,
    this.suffix,
    this.prefix,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = IntTween(
      begin: widget.start,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
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
        return Text(
          '${widget.prefix ?? ''}${_animation.value}${widget.suffix ?? ''}',
          style: widget.style,
        );
      },
    );
  }
}

/// Decorative divider with icon
class DecorativeDivider extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double height;

  const DecorativeDivider({super.key, this.icon, this.color, this.height = 40});

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.concrete;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, effectiveColor],
                ),
              ),
            ),
          ),
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(icon, color: effectiveColor, size: 20),
            ),
          ],
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [effectiveColor, Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Glowing badge
class GlowingBadge extends StatefulWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const GlowingBadge({
    super.key,
    required this.text,
    required this.color,
    this.icon,
  });

  @override
  State<GlowingBadge> createState() => _GlowingBadgeState();
}

class _GlowingBadgeState extends State<GlowingBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.color, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(_glowAnimation.value),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: widget.color, size: 16),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: widget.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
