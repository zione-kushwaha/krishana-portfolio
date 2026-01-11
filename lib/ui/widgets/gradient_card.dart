import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

/// A beautiful card with gradient background and glass morphism effect
class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool showBorder;
  final bool showShadow;
  final VoidCallback? onTap;

  const GradientCard({
    super.key,
    required this.child,
    this.gradient,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.showBorder = true,
    this.showShadow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(20);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.cardGradient1,
        borderRadius: effectiveBorderRadius,
        border: showBorder
            ? Border.all(color: AppColors.concrete, width: 1)
            : null,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: effectiveBorderRadius,
        child: card,
      );
    }

    return card;
  }
}

/// Card with glass morphism effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double blur;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.blur = 10,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(20);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.glassLight,
        borderRadius: effectiveBorderRadius,
        border: Border.all(color: AppColors.glassMorphismBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.white.withOpacity(0.1),
            BlendMode.lighten,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(24),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Animated hover card
class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const HoverCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.onTap,
    this.gradient,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _elevationAnimation = Tween<double>(
      begin: 4.0,
      end: 12.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  gradient: widget.gradient ?? AppColors.cardGradient1,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.primaryBlue
                        : AppColors.concrete,
                    width: _isHovered ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? AppColors.shadowColored
                          : AppColors.shadowMedium,
                      blurRadius: _elevationAnimation.value * 2,
                      offset: Offset(0, _elevationAnimation.value / 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: widget.padding ?? const EdgeInsets.all(24),
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
