import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

class AnimatedUnderlineText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Color? underlineColor;
  final double underlineHeight;

  const AnimatedUnderlineText({
    super.key,
    required this.text,
    this.style,
    this.underlineColor,
    this.underlineHeight = 4,
  });

  @override
  State<AnimatedUnderlineText> createState() => _AnimatedUnderlineTextState();
}

class _AnimatedUnderlineTextState extends State<AnimatedUnderlineText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: widget.style ?? Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return FractionallySizedBox(
              widthFactor: _animation.value,
              alignment: Alignment.centerLeft,
              child: Container(
                height: widget.underlineHeight,
                decoration: BoxDecoration(
                  color: widget.underlineColor ?? AppColors.accentOrange,
                  borderRadius: BorderRadius.circular(
                    widget.underlineHeight / 2,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
