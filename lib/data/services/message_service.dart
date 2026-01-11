import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact_message.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'contact_messages';

  /// Save a new contact message to Firebase
  Future<bool> saveMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final contactMessage = ContactMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        subject: subject,
        message: message,
        timestamp: DateTime.now(),
        isRead: false,
      );

      await _firestore
          .collection(_collectionName)
          .doc(contactMessage.id)
          .set(contactMessage.toFirestore());

      print('Message saved successfully to Firebase');
      return true;
    } catch (e) {
      print('Error saving message to Firebase: $e');
      return false;
    }
  }

  /// Fetch all contact messages from Firebase
  Future<List<ContactMessage>> getMessages() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ContactMessage.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching messages from Firebase: $e');
      return [];
    }
  }

  /// Mark a message as read
  Future<void> markAsRead(String messageId) async {
    try {
      await _firestore.collection(_collectionName).doc(messageId).update({
        'isRead': true,
      });
    } catch (e) {
      print('Error marking message as read: $e');
      rethrow;
    }
  }

  /// Delete a message
  Future<void> deleteMessage(String messageId) async {
    try {
      await _firestore.collection(_collectionName).doc(messageId).delete();
    } catch (e) {
      print('Error deleting message: $e');
      rethrow;
    }
  }

  /// Get unread message count
  Future<int> getUnreadCount() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('isRead', isEqualTo: false)
          .get();

      return querySnapshot.docs.length;
    } catch (e) {
      print('Error getting unread count: $e');
      return 0;
    }
  }
}
