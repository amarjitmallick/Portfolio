import 'identity.dart';
import 'models.dart';

/// §9 Contact: section copy and the one contact form definition.
abstract final class ContactCopy {
  static const TwoLine heading = TwoLine("LET'S WORK", 'TOGETHER');
  static const String subtitle =
      "Offline-first, on-device, hardware-connected, or just a good idea that needs a good app. Tell me what you're building.";
  static const String responseTime = 'Usually within 24 hours.';
  static const List<String> helpWith = [
    'Flutter apps (Android, iOS, web)',
    'offline-first and on-device features',
    'hardware and payment integrations',
    'taking an existing app to the next level',
  ];

  static const List<FieldCopy> fields = [
    FieldCopy(field: ContactField.name, label: 'Name', placeholder: 'What should I call you?'),
    FieldCopy(field: ContactField.email, label: 'Email', placeholder: 'you@company.com'),
    FieldCopy(field: ContactField.message, label: 'Message', placeholder: 'What are we building?'),
  ];

  static const String send = 'Send it';
  static const String sending = 'Sending…';
  static const String errorNoName = 'Please add your name';
  static const String errorNoEmail = 'Please add your email';
  static const String errorBadEmail = "That email doesn't look quite right";
  static const String errorNoMessage = 'Tell me a little about the project';
  static const String successTitle = 'Message sent.';
  static const String successBody = "I'll reply within a day.";
  static const String errorNoMailApp = "Couldn't open your mail app. You can write to ${Identity.email} directly.";
  static String errorOther(Object error) => 'Something went wrong: $error. Email me directly instead.';
  static const String mailSubject = 'New message from your portfolio';

  /// `{message}` + blank line + `{name}` + `{email}`.
  static String mailBody({required String name, required String email, required String message}) =>
      '$message\n\n$name\n$email\n';

  static final RegExp _email = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,}$');

  /// Returns the error copy for [field], or null when valid.
  static String? validate(ContactField field, String value) {
    final v = value.trim();
    switch (field) {
      case ContactField.name:
        return v.isEmpty ? errorNoName : null;
      case ContactField.email:
        if (v.isEmpty) return errorNoEmail;
        return _email.hasMatch(v) ? null : errorBadEmail;
      case ContactField.message:
        return v.isEmpty ? errorNoMessage : null;
    }
  }

  static Uri mailto({required String name, required String email, required String message}) => Uri(
    scheme: 'mailto',
    path: Identity.email,
    query:
        'subject=${Uri.encodeComponent(mailSubject)}'
        '&body=${Uri.encodeComponent(mailBody(name: name, email: email, message: message))}',
  );
}
