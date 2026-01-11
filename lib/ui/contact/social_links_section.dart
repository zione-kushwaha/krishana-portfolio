import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/constants/asset_paths.dart';
import '../../config/constants/personal_info.dart';
import '../../config/theme/app_colors.dart';
import '../widgets/section_header.dart';

class SocialLinksSection extends StatelessWidget {
  const SocialLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue.withOpacity(0.05),
            AppColors.vibrantPurple.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          const SectionHeader(
            title: "Let's Connect!",
            subtitle: "Reach out through your favorite platform",
          ),
          const SizedBox(height: 30),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CircularSocialButton(
                    icon: AssetPaths.emailIcon,
                    label: 'Gmail',
                    color: AppColors.accentOrange,
                    url: 'mailto:${PersonalInfo.email}',
                  ),
                  _CircularSocialButton(
                    icon: AssetPaths.facebookIcon,
                    label: 'Facebook',
                    color: const Color(0xFF1877F2),
                    url: PersonalInfo.facebookUrl,
                  ),
                  _CircularSocialButton(
                    icon: AssetPaths.instagramIcon,
                    label: 'Instagram',
                    color: const Color(0xFFE4405F),
                    url: PersonalInfo.instagramUrl,
                  ),
                  _CircularSocialButton(
                    icon: AssetPaths.linkedinIcon,
                    label: 'LinkedIn',
                    color: AppColors.primaryBlue,
                    url: PersonalInfo.linkedInUrl,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularSocialButton extends StatefulWidget {
  final String icon;
  final String label;
  final Color color;
  final String url;

  const _CircularSocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.url,
  });

  @override
  State<_CircularSocialButton> createState() => _CircularSocialButtonState();
}

class _CircularSocialButtonState extends State<_CircularSocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Tooltip(
          message: widget.label,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: GestureDetector(
              onTap: _launchUrl,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHovered ? widget.color : Colors.white,
                  border: Border.all(color: widget.color, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: _isHovered ? 15 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(widget.icon, width: 28, height: 28),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialCard extends StatefulWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;
  final String url;

  const _SocialCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.url,
  });

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchUrl() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: _launchUrl,
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered ? widget.color : AppColors.borderLight,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.color.withOpacity(0.3)
                      : AppColors.shadowLight,
                  blurRadius: _isHovered ? 20 : 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    widget.icon,
                    colorFilter: ColorFilter.mode(
                      widget.color,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.value,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Connect',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
