import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/data/models/blog_post.dart';
import 'package:krishna/data/services/blog_service.dart';
import 'package:toastification/toastification.dart';

class BlogAdminPanel extends StatefulWidget {
  const BlogAdminPanel({super.key});

  @override
  State<BlogAdminPanel> createState() => _BlogAdminPanelState();
}

class _BlogAdminPanelState extends State<BlogAdminPanel> {
  final BlogService _blogService = BlogService();
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _excerptController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _tagsController = TextEditingController();
  final _readTimeController = TextEditingController();

  bool _isPublished = true;
  bool _isLoading = false;
  List<BlogPost> _blogs = [];
  String? _editingBlogId;

  @override
  void initState() {
    super.initState();
    _loadBlogs();
  }

  Future<void> _loadBlogs() async {
    final blogs = await _blogService.getBlogs();
    setState(() {
      _blogs = blogs;
    });
  }

  void _editBlog(BlogPost blog) {
    setState(() {
      _editingBlogId = blog.id;
      _titleController.text = blog.title;
      _excerptController.text = blog.excerpt;
      _contentController.text = blog.content;
      _imageUrlController.text = blog.imageUrl;
      _tagsController.text = blog.tags.join(', ');
      _readTimeController.text = blog.readTimeMinutes.toString();
      _isPublished = blog.published;
    });
  }

  void _clearForm() {
    setState(() {
      _editingBlogId = null;
      _titleController.clear();
      _excerptController.clear();
      _contentController.clear();
      _imageUrlController.clear();
      _tagsController.clear();
      _readTimeController.clear();
      _isPublished = true;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _excerptController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    _tagsController.dispose();
    _readTimeController.dispose();
    super.dispose();
  }

  Future<void> _saveBlog() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final blog = BlogPost(
        id: _editingBlogId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        excerpt: _excerptController.text.trim(),
        content: _contentController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        author: 'Krishana',
        publishedDate: DateTime.now(),
        tags: _tagsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        readTimeMinutes: int.tryParse(_readTimeController.text) ?? 5,
        published: _isPublished,
      );

      await _blogService.saveBlog(blog);
      await _loadBlogs();

      if (mounted) {
        toastification.show(
          context: context,
          title: Text(
            _editingBlogId != null
                ? 'Blog updated successfully!'
                : 'Blog saved successfully!',
          ),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 3),
        );

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

  Future<void> _deleteBlog(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Blog'),
        content: const Text('Are you sure you want to delete this blog post?'),
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
        await _blogService.deleteBlog(id);
        await _loadBlogs();

        if (_editingBlogId == id) {
          _clearForm();
        }

        if (mounted) {
          toastification.show(
            context: context,
            title: const Text('Blog deleted successfully'),
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
                            _editingBlogId != null
                                ? 'Edit Blog Post'
                                : 'Create New Blog Post',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlue,
                                ),
                          ),
                        ),
                        if (_editingBlogId != null)
                          TextButton.icon(
                            onPressed: _clearForm,
                            icon: const Icon(Icons.clear),
                            label: const Text('Cancel Edit'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Write your blog content in Markdown format',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightText,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Blog Title *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Title is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // Excerpt
                    TextFormField(
                      controller: _excerptController,
                      decoration: const InputDecoration(
                        labelText: 'Excerpt / Summary *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.short_text),
                      ),
                      maxLines: 2,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Excerpt is required' : null,
                    ),
                    const SizedBox(height: 16),

                    // Content (Markdown)
                    TextFormField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'Blog Content (Markdown) *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.article),
                        hintText:
                            '# Heading 1\n\n## Heading 2\n\nParagraph text...\n\n- Bullet point\n- Another point',
                      ),
                      maxLines: 15,
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Content is required' : null,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _imageUrlController,
                            decoration: const InputDecoration(
                              labelText: 'Image URL',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.image),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _readTimeController,
                            decoration: const InputDecoration(
                              labelText: 'Read Time (minutes) *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.access_time),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) =>
                                value?.isEmpty ?? true ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tags
                    TextFormField(
                      controller: _tagsController,
                      decoration: const InputDecoration(
                        labelText: 'Tags (comma separated)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.tag),
                        hintText: 'Technology, Engineering, BIM',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Published Checkbox
                    SwitchListTile(
                      title: const Text('Publish immediately'),
                      subtitle: const Text('Make this blog visible to users'),
                      value: _isPublished,
                      onChanged: (value) {
                        setState(() => _isPublished = value);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _saveBlog,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                _editingBlogId != null
                                    ? Icons.update
                                    : Icons.save,
                              ),
                        label: Text(
                          _isLoading
                              ? 'Saving...'
                              : _editingBlogId != null
                              ? 'Update Blog'
                              : 'Publish Blog',
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

          // Blog List Section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Existing Blogs (${_blogs.length})',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _blogs.isEmpty
                      ? const Center(child: Text('No blogs created yet'))
                      : ListView.builder(
                          itemCount: _blogs.length,
                          itemBuilder: (context, index) {
                            final blog = _blogs[index];
                            final isEditing = _editingBlogId == blog.id;
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              color: isEditing
                                  ? AppColors.primaryBlue.withOpacity(0.1)
                                  : null,
                              child: ListTile(
                                leading: blog.imageUrl.isNotEmpty
                                    ? Image.network(
                                        blog.imageUrl,
                                        width: 80,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.article),
                                      )
                                    : const Icon(Icons.article, size: 40),
                                title: Text(
                                  blog.title,
                                  style: TextStyle(
                                    fontWeight: isEditing
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      blog.excerpt,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Wrap(
                                      spacing: 8,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              blog.published
                                                  ? Icons.check_circle
                                                  : Icons.unpublished,
                                              size: 16,
                                              color: blog.published
                                                  ? Colors.green
                                                  : Colors.orange,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              blog.published
                                                  ? 'Published'
                                                  : 'Draft',
                                              style: TextStyle(
                                                color: blog.published
                                                    ? Colors.green
                                                    : Colors.orange,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${blog.readTimeMinutes} min read',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                      onPressed: () => _editBlog(blog),
                                      tooltip: 'Edit',
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _deleteBlog(blog.id),
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
