import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String imageUrl;
  final String author;
  final DateTime publishedDate;
  final List<String> tags;
  final int readTimeMinutes;
  final bool published;

  BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.publishedDate,
    required this.tags,
    required this.readTimeMinutes,
    this.published = true,
  });

  /// Convert Firestore document to BlogPost
  factory BlogPost.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BlogPost(
      id: doc.id,
      title: data['title'] ?? '',
      excerpt: data['excerpt'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      author: data['author'] ?? 'Krishana',
      publishedDate:
          (data['publishedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      tags: List<String>.from(data['tags'] ?? []),
      readTimeMinutes: data['readTimeMinutes'] ?? 5,
      published: data['published'] ?? true,
    );
  }

  /// Convert BlogPost to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'excerpt': excerpt,
      'content': content,
      'imageUrl': imageUrl,
      'author': author,
      'publishedDate': Timestamp.fromDate(publishedDate),
      'tags': tags,
      'readTimeMinutes': readTimeMinutes,
      'published': published,
    };
  }

  static List<BlogPost> getSamplePosts() {
    return [
      BlogPost(
        id: '1',
        title: 'Sustainable Construction: The Future of Civil Engineering',
        excerpt:
            'Exploring how sustainable practices are revolutionizing modern construction and infrastructure development.',
        content: '''
# Sustainable Construction: The Future of Civil Engineering

Sustainability has become a cornerstone of modern civil engineering...

## Why Sustainable Construction Matters

- Reduces environmental impact
- Improves energy efficiency
- Long-term cost savings
- Better quality of life

## Key Principles

1. **Green Building Materials**: Using eco-friendly and recyclable materials
2. **Energy Efficiency**: Incorporating renewable energy sources
3. **Water Conservation**: Implementing efficient water management systems
4. **Waste Reduction**: Minimizing construction waste

This is just the beginning of our journey towards sustainable infrastructure!
        ''',
        imageUrl: 'assets/blog/sustainable-construction.jpg',
        author: 'Krishana',
        publishedDate: DateTime(2024, 1, 15),
        tags: ['Sustainability', 'Green Building', 'Environment'],
        readTimeMinutes: 5,
      ),
      BlogPost(
        id: '2',
        title: 'BIM Technology: Transforming Infrastructure Projects',
        excerpt:
            'How Building Information Modeling is changing the way we design, build, and maintain infrastructure.',
        content: '''
# BIM Technology: Transforming Infrastructure Projects

Building Information Modeling (BIM) represents a paradigm shift in civil engineering...

## Benefits of BIM

- Enhanced collaboration among stakeholders
- Improved project visualization
- Better cost estimation
- Clash detection before construction

## My Experience with BIM

Working with Revit and other BIM tools has opened new perspectives...
        ''',
        imageUrl: 'assets/blog/bim-technology.jpg',
        author: 'Krishana',
        publishedDate: DateTime(2024, 2, 1),
        tags: ['BIM', 'Technology', 'CAD'],
        readTimeMinutes: 7,
      ),
      BlogPost(
        id: '3',
        title: 'Structural Analysis: Understanding Load Paths',
        excerpt:
            'A comprehensive guide to understanding how forces flow through structures.',
        content: '''
# Structural Analysis: Understanding Load Paths

Understanding load paths is fundamental to structural design...

## Types of Loads

1. **Dead Loads**: Permanent structural loads
2. **Live Loads**: Temporary or moving loads
3. **Wind Loads**: Lateral forces from wind
4. **Seismic Loads**: Earthquake-induced forces

## Analysis Methods

- Static analysis
- Dynamic analysis
- Finite element method
        ''',
        imageUrl: 'assets/blog/structural-analysis.jpg',
        author: 'Krishana',
        publishedDate: DateTime(2024, 2, 20),
        tags: ['Structural Engineering', 'Analysis', 'Design'],
        readTimeMinutes: 8,
      ),
    ];
  }
}
