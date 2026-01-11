import 'package:flutter/material.dart';
import 'package:krishna/config/constants/navigation_tags.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/provider/current_tag_notifier.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:provider/provider.dart';

import '../admin/admin_login.dart';

class HomeAppBar extends StatefulWidget {
  final ScrollController scrollController;

  const HomeAppBar({super.key, required this.scrollController});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _isScrolled = false;
  int _tapCount = 0;
  DateTime? _lastTapTime;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final isScrolled = widget.scrollController.offset > 100;
    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }
  }

  void _onLogoTap() {
    final now = DateTime.now();
    if (_lastTapTime != null && now.difference(_lastTapTime!).inSeconds > 2) {
      _tapCount = 0;
    }
    _lastTapTime = now;
    _tapCount++;

    if (_tapCount >= 3) {
      _tapCount = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);
    final isDesktop = screen.type.isDesktop;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isScrolled ? AppColors.white : Colors.transparent,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: screen.contentPadding.copyWith(top: 16, bottom: 16),
          child: Row(
            children: [
              // Logo
              GestureDetector(
                onTap: _onLogoTap,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'K',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Krishana',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _isScrolled
                            ? AppColors.darkText
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Navigation
              if (isDesktop)
                _buildNavItems()
              else
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: _isScrolled ? AppColors.darkText : AppColors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItems() {
    return Consumer<CurrentTagNotifier>(
      builder: (context, notifier, _) {
        return Row(
          children: [
            ...kTagDisplayNames.entries.map((entry) {
              final isActive = notifier.currentTag == entry.key;
              return Padding(
                padding: const EdgeInsets.only(left: 24),
                child: _NavItem(
                  label: entry.value,
                  isActive: isActive,
                  isScrolled: _isScrolled,
                  onTap: () {
                    notifier.setCurrentTag(entry.key);
                  },
                ),
              );
            }).toList(),
            // Admin button removed; triple-tap on logo opens admin
          ],
        );
      },
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final bool isScrolled;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.isScrolled,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isScrolled ? AppColors.darkText : AppColors.white;
    final activeColor = widget.isScrolled
        ? AppColors.primaryBlue
        : AppColors.accentOrange;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isActive || _isHovered ? activeColor : color,
                fontSize: 16,
                fontWeight: widget.isActive
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: widget.isActive || _isHovered ? 40 : 0,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
