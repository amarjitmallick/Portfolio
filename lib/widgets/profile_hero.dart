import 'package:flutter/material.dart';
import 'package:portfolio/models/portfolio_models.dart';
import 'package:portfolio/widgets/social_links_bar.dart';

class ProfileHero extends StatelessWidget {
  final PersonalInfo personalInfo;
  final List<SocialLink> socialLinks;

  const ProfileHero({
    super.key,
    required this.personalInfo,
    required this.socialLinks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 80),
      padding: const EdgeInsets.all(40),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.shadow.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  personalInfo.profileImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              personalInfo.name,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "A Software Engineer who has developed countless innovative solutions",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          SocialLinksBar(links: socialLinks),
        ],
      ),
    );
  }
}
