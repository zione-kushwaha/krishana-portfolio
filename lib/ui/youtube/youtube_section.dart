import 'package:flutter/material.dart';
import 'package:krishna/config/constants/constants.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/data/models/youtube_video.dart';
import 'package:krishna/data/services/youtube_service.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/service_locator.dart';
import 'package:krishna/ui/widgets/animated_underline_text.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubeSection extends StatefulWidget {
  const YouTubeSection({super.key});

  @override
  State<YouTubeSection> createState() => _YouTubeSectionState();
}

class _YouTubeSectionState extends State<YouTubeSection> {
  final YouTubeService _youtubeService = locator<YouTubeService>();
  late Future<List<YouTubeVideo>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = _youtubeService.getVideos();
  }

  Future<void> _launchVideo(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);

    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: screen.contentPadding.copyWith(
        top: screen.h(8),
        bottom: screen.h(8),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Column(
            children: [
              const AnimatedUnderlineText(text: 'Educational Videos'),
              SizedBox(height: screen.h(2)),
              Text(
                'Learn from our comprehensive video tutorials',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.lightText),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screen.h(5)),
              FutureBuilder<List<YouTubeVideo>>(
                future: _videosFuture,
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
                        child: Text('Error loading videos: ${snapshot.error}'),
                      ),
                    );
                  }

                  final videos = snapshot.data ?? [];

                  if (videos.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.video_library_outlined,
                              size: 64,
                              color: AppColors.lightText,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No videos available yet.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add educational videos via the Admin Portal',
                              style: TextStyle(color: AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return _buildVideoGrid(context, screen, videos);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoGrid(
    BuildContext context,
    ScreenData screen,
    List<YouTubeVideo> videos,
  ) {
    final crossAxisCount = screen.fromMTD(1, 2, 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: screen.fromMTD(1.2, 1.1, 1.0),
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) => _VideoCard(
        video: videos[index],
        onTap: () => _launchVideo(videos[index].watchUrl),
      ),
    );
  }
}

class _VideoCard extends StatefulWidget {
  final YouTubeVideo video;
  final VoidCallback onTap;

  const _VideoCard({required this.video, required this.onTap});

  @override
  State<_VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<_VideoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
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
                // Thumbnail
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        widget.video.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          child: const Icon(
                            Icons.video_library,
                            size: 60,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    // Play button overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.video.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Description
                        if (widget.video.description.isNotEmpty)
                          Expanded(
                            child: Text(
                              widget.video.description,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.lightText,
                                    height: 1.5,
                                  ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
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
