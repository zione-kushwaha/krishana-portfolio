import 'package:flutter/material.dart';
import 'package:krishna/config/constants/constants.dart';
import 'package:krishna/config/theme/app_colors.dart';
import 'package:krishna/provider/message_sender_notifier.dart';
import 'package:krishna/responsive/responsive.dart';
import 'package:krishna/ui/widgets/animated_underline_text.dart';
import 'package:krishna/ui/widgets/custom_elevated_button.dart';
import 'package:krishna/data/services/contact_settings_service.dart';
import 'package:krishna/data/models/contact_settings.dart';
import 'package:krishna/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({super.key});

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final ContactSettingsService _settingsService =
      locator<ContactSettingsService>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = Screen.of(context);

    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: screen.contentPadding.copyWith(
        top: screen.h(8),
        bottom: screen.h(8),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Column(
            children: [
              const AnimatedUnderlineText(text: 'Get In Touch'),
              SizedBox(height: screen.h(2)),
              Text(
                'Have a question or want to work together? I\'d love to hear from you!',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.lightText),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screen.h(5)),
              screen.type.isDesktop
                  ? _buildDesktopLayout(screen)
                  : _buildMobileLayout(screen),
              SizedBox(height: screen.h(4)),
              // Copyright Text
              Center(
                child: Text(
                  '© 2026 Krishana Yadav. All rights reserved.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.lightText),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(ScreenData screen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildContactForm()),
        SizedBox(width: screen.w(5)),
        Expanded(child: _buildContactInfo()),
      ],
    );
  }

  Widget _buildMobileLayout(ScreenData screen) {
    return Column(
      children: [
        _buildContactInfo(),
        SizedBox(height: screen.h(4)),
        _buildContactForm(),
      ],
    );
  }

  Widget _buildContactForm() {
    return Consumer<MessageSenderNotifier>(
      builder: (context, notifier, _) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  hintText: 'John Doe',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  hintText: 'john@example.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  hintText: 'Project Inquiry',
                  prefixIcon: Icon(Icons.subject),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'Your message here...',
                  prefixIcon: Icon(Icons.message_outlined),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                text: notifier.state == MessageSendState.sending
                    ? 'Sending...'
                    : 'Send Message',
                icon: Icons.send,
                onPressed: notifier.state == MessageSendState.sending
                    ? () {}
                    : () => _sendMessage(notifier),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactInfo() {
    return FutureBuilder<ContactSettings>(
      future: _settingsService.getContactSettings(),
      builder: (context, snapshot) {
        final settings = snapshot.data ?? ContactSettings.defaultSettings;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _ContactInfoItem(
              icon: Icons.email,
              title: 'Email',
              value: settings.email,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: 16),
            _ContactInfoItem(
              icon: Icons.phone,
              title: 'Phone',
              value: settings.phone,
              color: AppColors.accentOrange,
            ),
            const SizedBox(height: 16),
            _ContactInfoItem(
              icon: Icons.location_on,
              title: 'Location',
              value: settings.location,
              color: AppColors.success,
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendMessage(MessageSenderNotifier notifier) async {
    if (_formKey.currentState!.validate()) {
      await notifier.sendMessage(
        name: _nameController.text,
        email: _emailController.text,
        messageText: _messageController.text,
        subject: _subjectController.text.isEmpty
            ? null
            : _subjectController.text,
      );

      if (!mounted) return;

      if (notifier.state == MessageSendState.success) {
        toastification.show(
          context: context,
          title: const Text('Success!'),
          description: Text(notifier.message),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          autoCloseDuration: const Duration(seconds: 3),
        );

        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      } else if (notifier.state == MessageSendState.error) {
        toastification.show(
          context: context,
          title: const Text('Error'),
          description: Text(notifier.message),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: AppColors.lightText),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
