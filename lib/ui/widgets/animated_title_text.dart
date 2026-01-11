import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

class AnimatedTitleText extends StatelessWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration duration;

  const AnimatedTitleText({
    super.key,
    required this.texts,
    this.style,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: texts.map((text) {
        return TypewriterAnimatedText(
          text,
          textStyle:
              style ??
              Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
          speed: const Duration(milliseconds: 100),
        );
      }).toList(),
      repeatForever: true,
      pause: const Duration(milliseconds: 1000),
    );
  }
}
