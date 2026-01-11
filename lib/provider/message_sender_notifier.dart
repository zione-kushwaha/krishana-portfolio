import 'package:flutter/material.dart';
import 'package:krishna/data/message_sender_api.dart';

enum MessageSendState { idle, sending, success, error }

class MessageSenderNotifier extends ChangeNotifier {
  final MessageSenderApi _api;

  MessageSenderNotifier(this._api);

  MessageSendState _state = MessageSendState.idle;
  String _message = '';

  MessageSendState get state => _state;
  String get message => _message;

  Future<void> sendMessage({
    required String name,
    required String email,
    required String messageText,
    String? subject,
  }) async {
    _state = MessageSendState.sending;
    notifyListeners();

    try {
      final result = await _api.sendMessage(
        name: name,
        email: email,
        message: messageText,
        subject: subject,
      );

      if (result.isSuccess) {
        _state = MessageSendState.success;
        _message = result.message;
      } else {
        _state = MessageSendState.error;
        _message = result.message;
      }
    } catch (e) {
      _state = MessageSendState.error;
      _message = 'An unexpected error occurred';
    }

    notifyListeners();

    // Reset to idle after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      resetState();
    });
  }

  void resetState() {
    _state = MessageSendState.idle;
    _message = '';
    notifyListeners();
  }
}
