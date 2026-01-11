import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krishna/data/models/contact_settings.dart';

class ContactSettingsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'settings';
  static const String _docId = 'contact';

  /// Get contact settings
  Future<ContactSettings> getContactSettings() async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(_docId)
          .get();

      if (doc.exists) {
        return ContactSettings.fromFirestore(doc);
      }

      // If no settings exist, create default ones
      final defaultSettings = ContactSettings.defaultSettings;
      await updateContactSettings(defaultSettings);
      return defaultSettings;
    } catch (e) {
      // Return default settings if there's an error
      return ContactSettings.defaultSettings;
    }
  }

  /// Update contact settings
  Future<void> updateContactSettings(ContactSettings settings) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(_docId)
          .set(settings.toFirestore(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update contact settings: $e');
    }
  }

  /// Stream contact settings for real-time updates
  Stream<ContactSettings> contactSettingsStream() {
    return _firestore.collection(_collectionName).doc(_docId).snapshots().map((
      snapshot,
    ) {
      if (snapshot.exists) {
        return ContactSettings.fromFirestore(snapshot);
      }
      return ContactSettings.defaultSettings;
    });
  }
}
