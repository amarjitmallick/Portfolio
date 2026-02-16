class PersonalInfo {
  final String name;
  final String title;
  final String bio;
  final String email;
  final String location;
  final String profileImage;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.bio,
    required this.email,
    required this.location,
    required this.profileImage,
  });
}

class Skill {
  final String name;
  final double proficiency;
  final String category;

  const Skill({
    required this.name,
    required this.proficiency,
    required this.category,
  });
}

class ProjectModel {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? demoUrl;
  final String? githubUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.demoUrl,
    this.githubUrl,
  });
}

class Publication {
  final String title;
  final String description;
  final String imageUrl;
  final String year;
  final String? blogUrl;

  const Publication({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.year,
    this.blogUrl,
  });
}

class CareerItem {
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> achievements;

  const CareerItem({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.achievements,
  });
}

class SocialLink {
  final String name;
  final String icon;
  final String url;

  const SocialLink({
    required this.name,
    required this.icon,
    required this.url,
  });
}

class StatItem {
  final String number;
  final String label;
  final dynamic
  icon; // Can be IconData or String asset path if needed, keeping generic for now

  const StatItem({
    required this.number,
    required this.label,
    this.icon,
  });
}
