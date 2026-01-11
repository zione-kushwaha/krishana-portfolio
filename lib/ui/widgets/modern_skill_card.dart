import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';

/// Modern skill card with icon, title, and progress
class ModernSkillCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? iconPath; // For SVG or image icons
  final double proficiency; // 0.0 to 1.0
  final Color? color;
  final VoidCallback? onTap;

  const ModernSkillCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconPath,
    required this.proficiency,
    this.color,
    this.onTap,
  });

  @override
  State<ModernSkillCard> createState() => _ModernSkillCardState();
}

class _ModernSkillCardState extends State<ModernSkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.proficiency,
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
    final theme = Theme.of(context);
    final effectiveColor = widget.color ?? AppColors.primaryBlue;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? LinearGradient(
                    colors: [effectiveColor.withOpacity(0.1), AppColors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [AppColors.white, AppColors.surfaceTint],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? effectiveColor : AppColors.concrete,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? effectiveColor.withOpacity(0.2)
                    : AppColors.shadowLight,
                blurRadius: _isHovered ? 15 : 8,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          effectiveColor,
                          effectiveColor.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: effectiveColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon ?? Icons.star,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.mediumText,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Percentage badge
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: effectiveColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: effectiveColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${(_progressAnimation.value * 100).toInt()}%',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: effectiveColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Progress bar
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _progressAnimation.value,
                          backgroundColor: AppColors.concrete,
                          valueColor: AlwaysStoppedAnimation(effectiveColor),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular skill badge
class CircularSkillBadge extends StatefulWidget {
  final String label;
  final IconData icon;
  final double proficiency;
  final Color color;

  const CircularSkillBadge({
    super.key,
    required this.label,
    required this.icon,
    required this.proficiency,
    required this.color,
  });

  @override
  State<CircularSkillBadge> createState() => _CircularSkillBadgeState();
}

class _CircularSkillBadgeState extends State<CircularSkillBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.proficiency,
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
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: _progressAnimation.value,
                      backgroundColor: AppColors.concrete,
                      valueColor: AlwaysStoppedAnimation(widget.color),
                      strokeWidth: 8,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 32),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Text(
              '${(_progressAnimation.value * 100).toInt()}%',
              style: theme.textTheme.bodySmall?.copyWith(
                color: widget.color,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }
}
