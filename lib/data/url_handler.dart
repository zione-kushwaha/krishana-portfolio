import 'package:url_launcher/url_launcher.dart';

class UrlHandler {
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> sendEmail(String email, {String? subject, String? body}) async {
    String emailUrl = 'mailto:$email';
    if (subject != null || body != null) {
      emailUrl += '?';
      if (subject != null) {
        emailUrl += 'subject=${Uri.encodeComponent(subject)}';
      }
      if (body != null) {
        if (subject != null) emailUrl += '&';
        emailUrl += 'body=${Uri.encodeComponent(body)}';
      }
    }
    await openUrl(emailUrl);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    await openUrl('tel:$phoneNumber');
  }

  Future<void> sendSMS(String phoneNumber, {String? message}) async {
    String smsUrl = 'sms:$phoneNumber';
    if (message != null) {
      smsUrl += '?body=${Uri.encodeComponent(message)}';
    }
    await openUrl(smsUrl);
  }
}
