import 'package:flutter/material.dart';
import 'package:krishna/config/constants/navigation_tags.dart';
import 'package:krishna/ui/widgets/auto_tagged_item.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/ui/about_me/enhanced_about_section.dart';
import 'package:krishna/ui/blog/blog_section.dart';
import 'package:krishna/ui/contact/contact_me.dart';
import 'package:krishna/ui/contact/social_links_section.dart';
import 'package:krishna/ui/home_welcome.dart';
import 'package:krishna/ui/navigation/home_appbar.dart';
import 'package:krishna/ui/navigation/home_drawer.dart';
import 'package:krishna/ui/skills/my_skills.dart';
import 'package:krishna/ui/youtube/youtube_section.dart';
import 'package:krishna/ui/widgets/auto_tagged_item.dart';
import 'package:krishna/ui/widgets/civil_engineering_decorations.dart';
import 'package:krishna/ui/widgets/tagged_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);
    final isSmallScreen = !screen.type.isDesktop;
    final drawer = isSmallScreen ? const HomeDrawer() : null;
    final isKeyboardClose = MediaQuery.viewInsetsOf(context).bottom == 0.0;

    return Scaffold(
      endDrawer: drawer,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          TaggedListView(
            scrollController: scrollController,
            children: [
              const AutoTaggedItem(tag: kHomeWelcomeTag, child: HomeWelcome()),
              screen.verticalSpace(8),
              const AutoTaggedItem(
                tag: kHomeAboutMeTag,
                child: EnhancedAboutSection(),
              ),

              const AutoTaggedItem(tag: kHomeSkillsTag, child: MySkills()),
              // screen.verticalSpace(10),
              // Fun Engineering Decoration Banner
              const ToolsBanner(),
              // screen.verticalSpace(10),
              const AutoTaggedItem(tag: kHomeBlogTag, child: BlogSection()),
              // screen.verticalSpace(10),
              const AutoTaggedItem(
                tag: kHomeVideosTag,
                child: YouTubeSection(),
              ),
              // screen.verticalSpace(10),
              const AutoTaggedItem(
                tag: kHomeContactTag,
                child: SocialLinksSection(),
              ),
              // screen.verticalSpace(8),
              const AutoTaggedItem(tag: 'contact_form', child: ContactMe()),
              screen.verticalSpace(8),
            ],
          ),
          if (isKeyboardClose) HomeAppBar(scrollController: scrollController),
        ],
      ),
    );
  }
}
