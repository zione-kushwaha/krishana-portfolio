import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/blog_post.dart';

class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'blogs';

  /// Fetch all published blogs from Firebase
  Future<List<BlogPost>> getBlogs() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('published', isEqualTo: true)
          .orderBy('publishedDate', descending: true)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No blogs found in Firebase. Please add blogs via Admin Portal.');
        return [];
      }

      return querySnapshot.docs
          .map((doc) => BlogPost.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching blogs from Firebase: $e');
      print('Make sure Firebase is properly configured.');
      return [];
    }
  }

  /// Add or update a blog post
  Future<void> saveBlog(BlogPost blog) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(blog.id)
          .set(blog.toFirestore(), SetOptions(merge: true));
    } catch (e) {
      print('Error saving blog: $e');
      rethrow;
    }
  }

  /// Delete a blog post
  Future<void> deleteBlog(String blogId) async {
    try {
      await _firestore.collection(_collectionName).doc(blogId).delete();
    } catch (e) {
      print('Error deleting blog: $e');
      rethrow;
    }
  }

  /// Get a single blog by ID
  Future<BlogPost?> getBlogById(String blogId) async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(blogId)
          .get();

      if (doc.exists) {
        return BlogPost.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error fetching blog: $e');
      return null;
    }
  }
}
