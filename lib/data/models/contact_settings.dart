import 'package:cloud_firestore/cloud_firestore.dart';

class ContactSettings {
  final String email;
  final String phone;
  final String location;
  final DateTime lastUpdated;

  ContactSettings({
    required this.email,
    required this.phone,
    required this.location,
    required this.lastUpdated,
  });

  /// Convert Firestore document to ContactSettings
  factory ContactSettings.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ContactSettings(
      email: data['email'] ?? 'ky39018@gmail.com',
      phone: data['phone'] ?? '+977 981-4777485',
      location: data['location'] ?? 'Dharan, Nepal',
      lastUpdated:
          (data['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Convert ContactSettings to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'phone': phone,
      'location': location,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }

  /// Default settings
  static ContactSettings get defaultSettings => ContactSettings(
    email: 'ky39018@gmail.com',
    phone: '+977 981-4777485',
    location: 'Dharan, Nepal',
    lastUpdated: DateTime.now(),
  );

  ContactSettings copyWith({
    String? email,
    String? phone,
    String? location,
    DateTime? lastUpdated,
  }) {
    return ContactSettings(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
