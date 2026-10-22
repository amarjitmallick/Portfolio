import 'flags.dart';
import 'models.dart';

/// §1 Identity: the single source of truth for who and where.
abstract final class Identity {
  static const String name = 'Amarjit Mallick';
  static const String title = 'Flutter engineer';
  static const String location = 'India';
  static const String email = 'mallickamarjit@gmail.com';

  /// Current employer, or the neutral descriptor while §12.1 is open.
  static String get employer => Verify.showEmployerName ? 'Sundew' : Verify.employerFallback;

  /// The only list of social links on the site.
  static const List<SocialLink> socials = [
    SocialLink(label: 'LinkedIn', url: 'https://www.linkedin.com/in/amarjit-mallick/'),
    SocialLink(label: 'GitHub', url: 'https://github.com/amarjitmallick'),
    SocialLink(label: 'X', url: 'https://x.com/amarjitmallick_'),
  ];
}
