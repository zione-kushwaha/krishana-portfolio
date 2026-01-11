import 'package:flutter/material.dart';
import 'package:krishna/config/constants/constants.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/config/constants/asset_paths.dart';
import 'package:krishna/data/models/blog_post.dart';
import 'package:krishna/data/services/blog_service.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/service_locator.dart';
import 'package:krishna/ui/widgets/animated_underline_text.dart';
import 'package:krishna/ui/blog/blog_detail.dart';
import 'package:intl/intl.dart';

class BlogSection extends StatefulWidget {
  const BlogSection({super.key});

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  final BlogService _blogService = locator<BlogService>();
  late Future<List<BlogPost>> _blogsFuture;

  @override
  void initState() {
    super.initState();
    _blogsFuture = _blogService.getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);

    return Container(
      width: double.infinity,
      color: AppColors.concreteLight,
      padding: screen.contentPadding.copyWith(
        top: screen.h(8),
        bottom: screen.h(8),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Column(
            children: [
              const AnimatedUnderlineText(text: 'Blog & Articles'),
              SizedBox(height: screen.h(2)),
              Text(
                'Sharing insights, experiences, and knowledge in civil engineering',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.lightText),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screen.h(5)),
              FutureBuilder<List<BlogPost>>(
                future: _blogsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text('Error loading blogs: ${snapshot.error}'),
                      ),
                    );
                  }

                  final blogPosts = snapshot.data ?? [];

                  if (blogPosts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 64,
                              color: AppColors.lightText,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No blogs available yet.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add new blogs via the Admin Portal',
                              style: TextStyle(color: AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return _buildBlogGrid(context, screen, blogPosts);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogGrid(
    BuildContext context,
    ScreenData screen,
    List<BlogPost> posts,
  ) {
    final crossAxisCount = screen.fromMTD(1, 2, 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: screen.fromMTD(0.9, 0.85, 0.75),
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) => _BlogCard(post: posts[index]),
    );
  }
}

class _BlogCard extends StatefulWidget {
  final BlogPost post;

  const _BlogCard({required this.post});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetail(post: widget.post),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0),
          child: Card(
            elevation: _isHovered ? 12 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _BlogImage(imageUrl: widget.post.imageUrl),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tags
                        Wrap(
                          spacing: 8,
                          children: widget.post.tags.take(2).map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                tag,
                                style: textTheme.labelSmall?.copyWith(
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        // Title
                        Text(
                          widget.post.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Excerpt
                        Expanded(
                          child: Text(
                            widget.post.excerpt,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.lightText,
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Meta info
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: AppColors.lightText,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat(
                                'MMM dd, yyyy',
                              ).format(widget.post.publishedDate),
                              style: textTheme.labelSmall?.copyWith(
                                color: AppColors.lightText,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.lightText,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.post.readTimeMinutes} min read',
                              style: textTheme.labelSmall?.copyWith(
                                color: AppColors.lightText,
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _BlogImage extends StatelessWidget {
  final String imageUrl;
  const _BlogImage({required this.imageUrl});

  bool get _isNetwork => imageUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    Widget fallback = Container(
      color: AppColors.primaryBlue.withOpacity(0.1),
      child: const Icon(Icons.article, size: 60, color: AppColors.primaryBlue),
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
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: progress.expectedTotalBytes != null
                      ? progress.cumulativeBytesLoaded /
                            (progress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder: (_, __, ___) => fallback,
          )
        : Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
          );
  }
}
