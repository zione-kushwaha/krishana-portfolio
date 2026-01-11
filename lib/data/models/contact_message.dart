import 'package:cloud_firestore/cloud_firestore.dart';

class ContactMessage {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  ContactMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  /// Convert Firestore document to ContactMessage
  factory ContactMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ContactMessage(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      subject: data['subject'] ?? 'No Subject',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  /// Convert ContactMessage to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
    };
  }
}
