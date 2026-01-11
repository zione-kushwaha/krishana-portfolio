import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constants/asset_paths.dart';
import '../../config/constants/personal_info.dart';
import '../../config/theme/app_colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/section_header.dart';

class EnhancedAboutSection extends StatelessWidget {
  const EnhancedAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.white, AppColors.primaryBlue.withOpacity(0.02)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SectionHeader(
                  title: "About ${PersonalInfo.fullName}",
                  subtitle: PersonalInfo.tagline,
                ),
                const SizedBox(height: 40),

                // Profile and Bio Section
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 768;

                    if (isMobile) {
                      return Column(
                        children: [
                          _buildProfileCard(),
                          const SizedBox(height: 30),
                          _buildBioCard(),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildProfileCard()),
                        const SizedBox(width: 30),
                        Expanded(flex: 3, child: _buildBioCard()),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 50),

                // Statistics
                _buildStatisticsSection(),

                const SizedBox(height: 50),

                // Achievements
                _buildAchievementsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return GlassCard(
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.vibrantPurple],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: ClipOval(
              child: Image.network(
                WebAssets.profilePlaceholder,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.asset(
                    AssetPaths.profileImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            PersonalInfo.fullName,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accentOrange, AppColors.vibrantYellow],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              PersonalInfo.designation,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            PersonalInfo.institution,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBioCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.vibrantPurple],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 15),
              Text(
                'My Story',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Text(
            PersonalInfo.longBio,
            style: TextStyle(
              fontSize: 16,
              height: 1.8,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 25),
          const Divider(),
          const SizedBox(height: 25),

          // Skills Tags
          Text(
            'Technical Skills',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: PersonalInfo.technicalSkills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final stats = [
      {
        'value': '${PersonalInfo.studentsMentored}+',
        'label': 'Students Mentored',
        'icon': Icons.school,
        'color': AppColors.accentOrange,
      },
      {
        'value': '${PersonalInfo.videoLectures}+',
        'label': 'Video Lectures',
        'icon': Icons.video_library,
        'color': AppColors.vibrantPurple,
      },
      {
        'value': '${PersonalInfo.studyMaterials}+',
        'label': 'Study Materials',
        'icon': Icons.menu_book,
        'color': AppColors.vibrantTeal,
      },
      {
        'value': '${PersonalInfo.studentSatisfaction}%',
        'label': 'Student Satisfaction',
        'icon': Icons.thumb_up,
        'color': AppColors.vibrantPink,
      },
    ];

    // Use LayoutBuilder to compute item width for responsive grid
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 20.0;
        final isMobile = constraints.maxWidth < 600;
        // For 2 columns on mobile: available width minus one spacing between
        final itemWidth = isMobile
            ? (constraints.maxWidth - spacing) / 2
            : 250.0;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: stats.map((stat) {
            return Container(
              width: itemWidth,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (stat['color'] as Color).withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (stat['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      size: 40,
                      color: stat['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    stat['value'] as String,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: stat['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    stat['label'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildAchievementsSection() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.vibrantYellow, AppColors.accentOrange],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  'Achievements & Recognition',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ...PersonalInfo.achievements.map((achievement) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.vibrantYellow,
                          AppColors.accentOrange,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.star, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      achievement,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
