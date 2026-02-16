import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/models/portfolio_models.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksBar extends StatelessWidget {
  final List<SocialLink> links;

  const SocialLinksBar({
    super.key,
    required this.links,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: links.map((link) {
              return IconButton(
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                tooltip: link.name,
                onPressed: () {
                  launchUrl(
                    Uri.parse(link.url),
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: SvgPicture.asset(
                  link.icon,
                  width: 36,
                  height: 36,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
