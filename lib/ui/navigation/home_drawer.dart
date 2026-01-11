import 'package:flutter/material.dart';
import 'package:krishna/config/constants/navigation_tags.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/provider/current_tag_notifier.dart';
import 'package:krishna/ui/admin/admin_login.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  int _tapCount = 0;
  late DateTime _lastTapTime;

  void _onKTap() {
    final now = DateTime.now();

    // Reset counter if more than 2 seconds have passed since last tap
    if (_lastTapTime != null && now.difference(_lastTapTime).inSeconds > 2) {
      _tapCount = 0;
    }

    _lastTapTime = now;
    _tapCount++;

    // Open admin portal on 3rd tap
    if (_tapCount >= 3) {
      _tapCount = 0;
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminLogin()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _lastTapTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo/Header
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _onKTap,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentOrange.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Text(
                          'K',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Krishana',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Civil Engineering Student',
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Divider(color: Colors.white24),
              const SizedBox(height: 16),
              // Navigation Items
              Expanded(
                child: Consumer<CurrentTagNotifier>(
                  builder: (context, notifier, _) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        ...kTagDisplayNames.entries.map((entry) {
                          final isActive = notifier.currentTag == entry.key;
                          return _DrawerItem(
                            label: entry.value,
                            isActive: isActive,
                            icon: _getIconForTag(entry.key),
                            onTap: () {
                              Navigator.pop(context);
                              notifier.setCurrentTag(entry.key);
                            },
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
              ),
              const Divider(color: Colors.white24),
              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '© 2026 Krishna Kumar Yadav. All rights reserved.',
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForTag(String tag) {
    switch (tag) {
      case kHomeWelcomeTag:
        return Icons.home;
      case kHomeAboutMeTag:
        return Icons.person;
      case kHomeSkillsTag:
        return Icons.stars;
      case kHomeVideosTag:
        return Icons.video_library;
      case kHomeBlogTag:
        return Icons.article;
      case kHomeContactTag:
        return Icons.mail;
      default:
        return Icons.circle;
    }
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.label,
    required this.isActive,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? AppColors.accentOrange : AppColors.white,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
