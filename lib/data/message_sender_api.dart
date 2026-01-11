import 'package:krishna/data/services/message_service.dart';

class MessageSenderApi {
  final MessageService _messageService;

  MessageSenderApi(this._messageService);

  Future<MessageSendResult> sendMessage({
    required String name,
    required String email,
    required String message,
    String? subject,
  }) async {
    try {
      // Save message to Firebase
      final success = await _messageService.saveMessage(
        name: name,
        email: email,
        subject: subject ?? 'Contact from Portfolio',
        message: message,
      );

      if (success) {
        return MessageSendResult.success(
          'Message sent successfully! We\'ll get back to you soon.',
        );
      } else {
        return MessageSendResult.error(
          'Failed to send message. Please try again.',
        );
      }
    } catch (e) {
      return MessageSendResult.error('An error occurred: ${e.toString()}');
    }
  }
}

class MessageSendResult {
  final bool isSuccess;
  final String message;

  MessageSendResult.success(this.message) : isSuccess = true;
  MessageSendResult.error(this.message) : isSuccess = false;
}
