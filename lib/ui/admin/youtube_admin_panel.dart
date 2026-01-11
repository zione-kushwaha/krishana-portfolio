import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/data/models/youtube_video.dart';
import 'package:krishna/data/services/youtube_service.dart';
import 'package:toastification/toastification.dart';

class YouTubeAdminPanel extends StatefulWidget {
  const YouTubeAdminPanel({super.key});

  @override
  State<YouTubeAdminPanel> createState() => _YouTubeAdminPanelState();
}

class _YouTubeAdminPanelState extends State<YouTubeAdminPanel> {
  final YouTubeService _youtubeService = YouTubeService();
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _videoIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _orderController = TextEditingController();

  bool _isLoading = false;
  List<YouTubeVideo> _videos = [];
  String? _editingVideoId;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final videos = await _youtubeService.getVideos();
    setState(() {
      _videos = videos;
    });
  }

  void _editVideo(YouTubeVideo video) {
    setState(() {
      _editingVideoId = video.id;
      _titleController.text = video.title;
      _videoIdController.text = video.videoId;
      _descriptionController.text = video.description;
      _orderController.text = video.displayOrder.toString();
    });
  }

  void _clearForm() {
    setState(() {
      _editingVideoId = null;
      _titleController.clear();
      _videoIdController.clear();
      _descriptionController.clear();
      _orderController.clear();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _videoIdController.dispose();
    _descriptionController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  String _extractVideoId(String input) {
    // Extract video ID from various YouTube URL formats
    final patterns = [
      RegExp(r'(?:youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]{11})'),
      RegExp(r'^([a-zA-Z0-9_-]{11})$'), // Direct video ID
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(input);
      if (match != null) {
        return match.group(1)!;
      }
    }
    return input; // Return as-is if no pattern matches
  }

  Future<void> _saveVideo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final videoId = _extractVideoId(_videoIdController.text.trim());

      final video = YouTubeVideo(
        id: _editingVideoId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        videoId: videoId,
        description: _descriptionController.text.trim(),
        thumbnailUrl: 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg',
        addedDate: DateTime.now(),
        displayOrder: int.tryParse(_orderController.text) ?? 0,
      );

      await _youtubeService.saveVideo(video);
      await _loadVideos();

      if (mounted) {
        toastification.show(
          context: context,
          title: Text(
            _editingVideoId != null
                ? 'Video updated successfully!'
                : 'Video added successfully!',
          ),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 3),
        );

        // Clear form
        _clearForm();
        _formKey.currentState!.reset();
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          title: Text('Error: $e'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteVideo(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Video'),
        content: const Text('Are you sure you want to delete this video?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _youtubeService.deleteVideo(id);
        await _loadVideos();

        if (_editingVideoId == id) {
          _clearForm();
        }

        if (mounted) {
          toastification.show(
            context: context,
            title: const Text('Video deleted successfully'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      } catch (e) {
        if (mounted) {
          toastification.show(
            context: context,
            title: Text('Error: $e'),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Section
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _editingVideoId != null
                                ? 'Edit YouTube Video'
                                : 'Add YouTube Video',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlue,
                                ),
                          ),
                        ),
                        if (_editingVideoId != null)
                          TextButton.icon(
                            onPressed: _clearForm,
                            icon: const Icon(Icons.clear),
                            label: const Text('Cancel Edit'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add educational videos from YouTube',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Video Title *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Title is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // Video ID/URL
                    TextFormField(
                      controller: _videoIdController,
                      decoration: const InputDecoration(
                        labelText: 'YouTube Video ID or URL *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.video_library),
                        hintText: 'dQw4w9WgXcQ or full YouTube URL',
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Video ID is required'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Display Order
                    TextFormField(
                      controller: _orderController,
                      decoration: const InputDecoration(
                        labelText: 'Display Order',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.sort),
                        hintText: '1, 2, 3...',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _saveVideo,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                _editingVideoId != null
                                    ? Icons.update
                                    : Icons.add,
                              ),
                        label: Text(
                          _isLoading
                              ? 'Saving...'
                              : _editingVideoId != null
                              ? 'Update Video'
                              : 'Add Video',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),

          // Video List Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Videos (${_videos.length})',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _videos.isEmpty
                      ? const Center(child: Text('No videos added yet'))
                      : ListView.builder(
                          itemCount: _videos.length,
                          itemBuilder: (context, index) {
                            final video = _videos[index];
                            final isEditing = _editingVideoId == video.id;
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              color: isEditing
                                  ? AppColors.primaryBlue.withOpacity(0.1)
                                  : null,
                              child: ListTile(
                                leading: Image.network(
                                  video.thumbnailUrl,
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.video_library),
                                ),
                                title: Text(
                                  video.title,
                                  style: TextStyle(
                                    fontWeight: isEditing
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  'Order: ${video.displayOrder}\n${video.videoId}',
                                ),
                                isThreeLine: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isEditing
                                            ? Icons.edit
                                            : Icons.edit_outlined,
                                        color: AppColors.primaryBlue,
                                      ),
                                      onPressed: () => _editVideo(video),
                                      tooltip: 'Edit',
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _deleteVideo(video.id),
                                      tooltip: 'Delete',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
