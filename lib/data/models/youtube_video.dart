import 'package:cloud_firestore/cloud_firestore.dart';

class YouTubeVideo {
  final String id;
  final String title;
  final String videoId; // YouTube video ID
  final String description;
  final String thumbnailUrl;
  final DateTime addedDate;
  final int displayOrder;

  YouTubeVideo({
    required this.id,
    required this.title,
    required this.videoId,
    required this.description,
    required this.thumbnailUrl,
    required this.addedDate,
    this.displayOrder = 0,
  });

  /// Get YouTube embed URL
  String get embedUrl => 'https://www.youtube.com/embed/$videoId';

  /// Get YouTube watch URL
  String get watchUrl => 'https://www.youtube.com/watch?v=$videoId';

  /// Convert Firestore document to YouTubeVideo
  factory YouTubeVideo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return YouTubeVideo(
      id: doc.id,
      title: data['title'] ?? '',
      videoId: data['videoId'] ?? '',
      description: data['description'] ?? '',
      thumbnailUrl:
          data['thumbnailUrl'] ??
          'https://img.youtube.com/vi/${data['videoId']}/maxresdefault.jpg',
      addedDate: (data['addedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      displayOrder: data['displayOrder'] ?? 0,
    );
  }

  /// Convert YouTubeVideo to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'videoId': videoId,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'addedDate': Timestamp.fromDate(addedDate),
      'displayOrder': displayOrder,
    };
  }

  /// Get sample videos
  static List<YouTubeVideo> getSampleVideos() {
    return [
      YouTubeVideo(
        id: '1',
        title: 'Introduction to Structural Analysis',
        videoId: 'dQw4w9WgXcQ', // Replace with actual video ID
        description: 'Learn the fundamentals of structural analysis',
        thumbnailUrl:
            'https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg',
        addedDate: DateTime.now(),
        displayOrder: 1,
      ),
      YouTubeVideo(
        id: '2',
        title: 'AutoCAD Tutorial for Civil Engineers',
        videoId: 'dQw4w9WgXcQ', // Replace with actual video ID
        description: 'Master AutoCAD for civil engineering projects',
        thumbnailUrl:
            'https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg',
        addedDate: DateTime.now(),
        displayOrder: 2,
      ),
    ];
  }
}
