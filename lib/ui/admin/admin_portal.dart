import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/ui/admin/blog_admin_panel.dart';
import 'package:krishna/ui/admin/youtube_admin_panel.dart';
import 'package:krishna/ui/admin/messages_admin_panel.dart';
import 'package:krishna/ui/admin/contact_settings_admin.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BlogAdminPanel(),
    const YouTubeAdminPanel(),
    const MessagesAdminPanel(),
    const ContactSettingsAdmin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Portal - Infinity Academy'),
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: Row(
        children: [
          // Sidebar Navigation
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.article_outlined),
                selectedIcon: Icon(Icons.article),
                label: Text('Blog Management'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.video_library_outlined),
                selectedIcon: Icon(Icons.video_library),
                label: Text('YouTube Videos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.message_outlined),
                selectedIcon: Icon(Icons.message),
                label: Text('Messages'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Contact Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main Content
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}
