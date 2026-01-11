import 'package:flutter/material.dart';
import 'package:krishna/config/constants/constants.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/ui/widgets/animated_underline_text.dart';

class MySkills extends StatelessWidget {
  const MySkills({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);

    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: screen.contentPadding.copyWith(
        top: screen.h(5),
        bottom: screen.h(5),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Column(
            children: [
              const AnimatedUnderlineText(text: 'Skills & Expertise'),
              // SizedBox(height: screen.h(5)),
              _buildSkillsGrid(screen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(ScreenData screen) {
    final skills = _getSkillsList();
    final crossAxisCount = screen.fromMTD(1, 2, 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: screen.fromMTD(1.5, 1.3, 1.2),
        mainAxisExtent: screen.fromMTD(250, 300, 350),
      ),

      itemCount: skills.length,
      itemBuilder: (context, index) => _SkillCard(skill: skills[index]),
    );
  }

  List<Skill> _getSkillsList() {
    return [
      Skill(
        title: 'Structural Analysis',
        icon: Icons.analytics_outlined,
        color: AppColors.primaryBlue,
        items: ['STAAD Pro', 'ETABS', 'SAP 2000', 'Hand Calculations'],
      ),
      Skill(
        title: 'CAD & Design',
        icon: Icons.architecture,
        color: AppColors.accentOrange,
        items: ['AutoCAD', 'Revit', 'SketchUp', 'Civil 3D'],
      ),
      Skill(
        title: 'Project Management',
        icon: Icons.manage_accounts,
        color: AppColors.steelGray,
        items: ['MS Project', 'Primavera', 'Planning', 'Cost Estimation'],
      ),
      Skill(
        title: 'Surveying',
        icon: Icons.explore,
        color: AppColors.success,
        items: ['Total Station', 'GPS/GNSS', 'Leveling', 'Digital Mapping'],
      ),
      Skill(
        title: 'BIM & Technology',
        icon: Icons.computer,
        color: AppColors.info,
        items: ['Revit BIM', '3D Modeling', 'Clash Detection', 'Visualization'],
      ),
      Skill(
        title: 'Web Development',
        icon: Icons.web,
        color: AppColors.vibrantPurple,
        items: ['WordPress', 'Web Design', 'CMS', 'Digital Marketing'],
      ),
      Skill(
        title: 'Soft Skills',
        icon: Icons.psychology,
        color: AppColors.warning,
        items: ['Leadership', 'Teamwork', 'Communication', 'Problem Solving'],
      ),
    ];
  }
}

class Skill {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  Skill({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class _SkillCard extends StatefulWidget {
  final Skill skill;

  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _isHovered ? 16 : 8,
              shadowColor: widget.skill.color.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: _isHovered ? widget.skill.color : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: _isHovered
                      ? LinearGradient(
                          colors: [
                            widget.skill.color.withOpacity(0.05),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: widget.skill.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.skill.icon,
                        color: widget.skill.color,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.skill.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.skill.items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: widget.skill.color,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.skill.items[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.lightText),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
