import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new tab (web) or the external app.
Future<bool> openExternal(String url) =>
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
