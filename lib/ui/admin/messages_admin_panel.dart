import 'package:flutter/material.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/data/models/contact_message.dart';
import 'package:krishna/data/services/message_service.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class MessagesAdminPanel extends StatefulWidget {
  const MessagesAdminPanel({super.key});

  @override
  State<MessagesAdminPanel> createState() => _MessagesAdminPanelState();
}

class _MessagesAdminPanelState extends State<MessagesAdminPanel> {
  final MessageService _messageService = MessageService();
  List<ContactMessage> _messages = [];
  bool _isLoading = true;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    final messages = await _messageService.getMessages();
    final unread = await _messageService.getUnreadCount();
    setState(() {
      _messages = messages;
      _unreadCount = unread;
      _isLoading = false;
    });
  }

  Future<void> _markAsRead(ContactMessage message) async {
    try {
      await _messageService.markAsRead(message.id);
      await _loadMessages();

      if (mounted) {
        toastification.show(
          context: context,
          title: const Text('Message marked as read'),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          context: context,
          title: Text('Error: $e'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> _deleteMessage(String messageId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Message'),
        content: const Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _messageService.deleteMessage(messageId);
        await _loadMessages();

        if (mounted) {
          toastification.show(
            context: context,
            title: const Text('Message deleted'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 2),
          );
        }
      } catch (e) {
        if (mounted) {
          toastification.show(
            context: context,
            title: Text('Error: $e'),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 3),
          );
        }
      }
    }
  }

  void _viewMessage(ContactMessage message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message.subject,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              _DetailRow(
                icon: Icons.person,
                label: 'Name',
                value: message.name,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.email,
                label: 'Email',
                value: message.email,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.access_time,
                label: 'Date',
                value: DateFormat(
                  'MMM dd, yyyy - HH:mm',
                ).format(message.timestamp),
              ),
              const SizedBox(height: 16),
              const Text(
                'Message:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message.message,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!message.isRead)
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _markAsRead(message);
                      },
                      icon: const Icon(Icons.mark_email_read),
                      label: const Text('Mark as Read'),
                    ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteMessage(message.id);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Contact Messages',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 16),
                if (_unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_unreadCount new',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadMessages,
                  tooltip: 'Refresh',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'View and manage messages from your portfolio contact form',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.lightText),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _messages.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mail_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No messages yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Messages from contact form will appear here'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: message.isRead ? null : Colors.blue[50],
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: message.isRead
                                  ? Colors.grey
                                  : AppColors.primaryBlue,
                              child: Icon(
                                message.isRead
                                    ? Icons.mail_outline
                                    : Icons.mail,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              message.name,
                              style: TextStyle(
                                fontWeight: message.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(message.email),
                                const SizedBox(height: 4),
                                Text(
                                  message.subject,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat(
                                    'MMM dd, yyyy - HH:mm',
                                  ).format(message.timestamp),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!message.isRead)
                                  IconButton(
                                    icon: const Icon(Icons.mark_email_read),
                                    onPressed: () => _markAsRead(message),
                                    tooltip: 'Mark as read',
                                  ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _deleteMessage(message.id),
                                  tooltip: 'Delete',
                                ),
                              ],
                            ),
                            onTap: () => _viewMessage(message),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryBlue),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
