import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:krishna/config/constants/constants.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/config/constants/asset_paths.dart';
import 'package:krishna/data/models/blog_post.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:intl/intl.dart';

class BlogDetail extends StatelessWidget {
  final BlogPost post;

  const BlogDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: screen.fromMTD(200.0, 250.0, 300.0),
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                post.title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: _DetailHeaderImage(imageUrl: post.imageUrl),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: screen.contentPadding.copyWith(
                top: screen.h(4),
                bottom: screen.h(4),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // Fill full width on mobile, wider on desktop
                    maxWidth: screen.fromMTD(double.infinity, 960.0, 1100.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Meta information
                      _buildMetaInfo(context),
                      SizedBox(height: screen.h(3)),
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: post.tags.map((tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: AppColors.primaryBlue.withOpacity(
                              0.1,
                            ),
                            labelStyle: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: screen.h(3)),
                      const Divider(),
                      SizedBox(height: screen.h(3)),
                      // Content
                      MarkdownBody(
                        data: post.content,
                        styleSheet: MarkdownStyleSheet(
                          h1: Theme.of(context).textTheme.displaySmall,
                          h2: Theme.of(context).textTheme.headlineMedium,
                          h3: Theme.of(context).textTheme.headlineSmall,
                          p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.8,
                            color: AppColors.darkText,
                          ),
                          listBullet: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.concreteLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryBlue,
            child: Icon(Icons.person, color: AppColors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.author,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.lightText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('MMMM dd, yyyy').format(post.publishedDate),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.lightText,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.lightText,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.readTimeMinutes} min read',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.lightText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailHeaderImage extends StatelessWidget {
  final String imageUrl;
  const _DetailHeaderImage({required this.imageUrl});

  bool get _isNetwork => imageUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    Widget fallback = Container(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: const Icon(Icons.article, size: 100, color: Colors.white24),
    );

    if (imageUrl.isEmpty) {
      return Image.asset(
        AssetPaths.blogDefaultThumb,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return _isNetwork
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
          );
  }
}
