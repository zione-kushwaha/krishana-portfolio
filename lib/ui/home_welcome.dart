import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishna/config/constants/asset_paths.dart';
import 'package:krishna/config/constants/constants.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/ui/widgets/animated_backgrounds.dart';
import 'package:krishna/ui/widgets/animated_title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWelcome extends StatelessWidget {
  const HomeWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);
    final isDesktop = screen.type.isDesktop;

    return SizedBox(
      width: double.infinity,
      height: screen.height,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              WebAssets.engineeringDeskBackground,
              fit: BoxFit.cover,
              cacheHeight: 1080,
              cacheWidth: 1920,
              errorBuilder: (context, error, stackTrace) {
                print('Background image failed to load: $error');
                return AnimatedGradientBackground(
                  colors: const [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                  child: Container(),
                );
              },
            ),
          ),
          // Dark overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          // Floating decorative shapes
          const Positioned.fill(child: FloatingShapes(numberOfShapes: 6)),
          // Main content
          Padding(
            padding: screen.contentPadding.copyWith(
              top: screen.h(isDesktop ? 8 : 6),
              bottom: screen.h(isDesktop ? 6 : 4),
            ),
            child: screen.type.isDesktop
                ? _buildDesktopLayout(context, screen)
                : _buildMobileLayout(context, screen),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ScreenData screen) {
    return Row(
      children: [
        Expanded(child: _buildContent(context, screen)),
        SizedBox(width: screen.w(5)),
        Expanded(child: _buildImageSection(screen)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, ScreenData screen) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageSection(screen),
          SizedBox(height: screen.h(2)),
          _buildContent(context, screen),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, ScreenData screen) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: screen.type.isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accentOrange.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.waving_hand,
                color: AppColors.vibrantYellow,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Hello, I\'m',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screen.h(1.5)),

        // Animated name
        AnimatedTitleText(
          texts: [kOwnerName, 'Civil Engineer'],
          style: textTheme.displayMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: screen.fromMTD(32.0, 40.0, 52.0),
            height: 1.2,
          ),
        ),
        SizedBox(height: screen.h(1.5)),

        // Title with gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.accentOrange, AppColors.vibrantYellow],
          ).createShader(bounds),
          child: Text(
            kOwnerFullTitle,
            style: textTheme.titleLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: screen.fromMTD(18.0, 20.0, 24.0),
            ),
          ),
        ),
        SizedBox(height: screen.h(1)),

        // Institution
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.school,
              color: AppColors.electricBlue,
              size: screen.fromMTD(18.0, 20.0, 22.0),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                kOwnerInstitution,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.white.withOpacity(0.85),
                  fontSize: screen.fromMTD(14.0, 15.0, 16.0),
                ),
                textAlign: screen.type.isMobile
                    ? TextAlign.center
                    : TextAlign.start,
              ),
            ),
          ],
        ),
        SizedBox(height: screen.h(2)),

        // Description
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            'Passionate about building sustainable infrastructure and innovative engineering solutions that shape the future.',
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.white.withOpacity(0.95),
              height: 1.6,
              fontSize: screen.fromMTD(14.0, 15.0, 16.0),
            ),
            textAlign: screen.type.isMobile
                ? TextAlign.center
                : TextAlign.start,
          ),
        ),
        SizedBox(height: screen.h(2.5)),

        // Action buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: screen.type.isMobile
              ? WrapAlignment.center
              : WrapAlignment.start,
          children: [
            _buildGradientButton(
              text: 'view Infinity Academy',
              icon: Icons.work_outline,
              gradient: const LinearGradient(
                colors: [AppColors.accentOrange, AppColors.accentOrangeLight],
              ),
              onPressed: () async {
                // TODO: Scroll to projects section
                // or open Infinity Academy link
                await launchUrl(
                  Uri.parse(
                    'https://www.facebook.com/p/Infinity-Academy-61570937553533/',
                  ),
                );
              },
            ),
            _buildGradientButton(
              text: 'Contact Me',
              icon: Icons.email_outlined,
              gradient: const LinearGradient(
                colors: [AppColors.electricBlue, AppColors.primaryBlueLight],
              ),
              onPressed: () {
                // TODO: Scroll to contact section
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGradientButton({
    required String text,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildImageSection(ScreenData screen) {
    return Center(
      child: Container(
        width: screen.fromMTD(200.0, 300.0, 400.0),
        height: screen.fromMTD(200.0, 300.0, 400.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.accentOrange, AppColors.vibrantPink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentOrange.withOpacity(0.4),
              blurRadius: 40,
              spreadRadius: 10,
            ),
            BoxShadow(
              color: AppColors.vibrantPink.withOpacity(0.3),
              blurRadius: 60,
              spreadRadius: 20,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.1),
              border: Border.all(
                color: AppColors.white.withOpacity(0.3),
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                WebAssets.profilePlaceholder,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    AssetPaths.profileImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
