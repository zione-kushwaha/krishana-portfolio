import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Container(
          width: widget.width,
          height: widget.height ?? 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.backgroundColor ?? AppColors.primaryBlue,
                widget.backgroundColor?.withOpacity(0.8) ??
                    AppColors.primaryBlueDark,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (widget.backgroundColor ?? AppColors.primaryBlue)
                    .withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: widget.foregroundColor ?? AppColors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.foregroundColor ?? AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
