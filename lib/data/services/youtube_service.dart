import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/youtube_video.dart';

class YouTubeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'youtube_videos';

  /// Fetch all YouTube videos from Firebase
  Future<List<YouTubeVideo>> getVideos() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('displayOrder')
          .get();

      if (querySnapshot.docs.isEmpty) {
        print(
          'No videos found in Firebase. Please add videos via Admin Portal.',
        );
        return [];
      }

      return querySnapshot.docs
          .map((doc) => YouTubeVideo.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching videos from Firebase: $e');
      print('Make sure Firebase is properly configured.');
      return [];
    }
  }

  /// Add or update a YouTube video
  Future<void> saveVideo(YouTubeVideo video) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(video.id)
          .set(video.toFirestore(), SetOptions(merge: true));
    } catch (e) {
      print('Error saving video: $e');
      rethrow;
    }
  }

  /// Delete a YouTube video
  Future<void> deleteVideo(String videoId) async {
    try {
      await _firestore.collection(_collectionName).doc(videoId).delete();
    } catch (e) {
      print('Error deleting video: $e');
      rethrow;
    }
  }

  /// Get a single video by ID
  Future<YouTubeVideo?> getVideoById(String videoId) async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(videoId)
          .get();

      if (doc.exists) {
        return YouTubeVideo.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error fetching video: $e');
      return null;
    }
  }
}
