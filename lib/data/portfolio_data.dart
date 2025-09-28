import '../models/portfolio_models.dart';

class PortfolioData {
  static const personalInfo = PersonalInfo(
    name: 'Amarjit Mallick',
    title: 'Mobile Application Developer',
    bio:
        'Passionate developer with 3+ years of experience creating innovative cross platform mobile and web applications. I love turning complex problems into simple, beautiful designs.',
    email: 'mallickamarjit@gmail.com',
    location: 'India',
    profileImage: 'assets/images/profile.jpeg',
  );

  static const skills = [
    Skill(name: 'Flutter', proficiency: 0.95, category: 'Frontend'),
    Skill(name: 'Dart', proficiency: 0.90, category: 'Frontend'),
    Skill(name: 'BLoC', proficiency: 0.90, category: 'State Management'),
    Skill(name: 'GetX', proficiency: 0.90, category: 'State Management'),
    Skill(name: 'MobX', proficiency: 0.90, category: 'State Management'),
    Skill(name: 'Provider', proficiency: 0.90, category: 'State Management'),
    Skill(name: 'Hive', proficiency: 0.90, category: 'Local Storage'),
    Skill(name: 'Firebase', proficiency: 0.88, category: 'Database'),
    Skill(name: 'Supabase', proficiency: 0.82, category: 'Database'),
    Skill(name: 'AWS', proficiency: 0.75, category: 'Database'),
    Skill(name: 'GitHub Actions', proficiency: 0.70, category: 'DevOps'),
    Skill(name: 'Figma', proficiency: 0.90, category: 'Design'),
  ];

  static const projects = [
    ProjectModel(
      title: 'GDG Siliguri App',
      description:
          'Flutter app for DevFest schedules and real-time updates, supporting 100+ installs and seamless dynamic event content.',
      imageUrl: 'assets/images/gdg_siliguri.webp',
      technologies: ['Flutter', 'Firebase'],
      demoUrl: 'https://play.google.com/store/apps/details?id=com.amarjitmallick.gdg_siliguri',
    ),
    ProjectModel(
      title: 'Xpense',
      description:
          'An offline-first expense tracker designed with a lightweight UI optimized for low battery and memory usage.',
      imageUrl: 'assets/images/xpense.webp',
      technologies: ['Flutter', 'Dart', 'Hive'],
      demoUrl: 'https://play.google.com/store/apps/details?id=me.amarjitmallick.xpense',
    ),
    ProjectModel(
      title: 'FarmOps',
      description: 'A Flutter-based farm management app for agronomists, improving field operations and productivity.',
      imageUrl: 'assets/images/farmops.webp',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Hive', 'BLoC', 'Rest API'],
      demoUrl: 'https://play.google.com/store/apps/details?id=com.hosachiguru.farmops',
    ),
  ];

  static const careerItems = [
    CareerItem(
      company: 'Sundew',
      position: 'Associate Flutter Developer (A2)',
      duration: 'Sept 2025 – Present',
      description: '',
      achievements: [],
    ),
    CareerItem(
      company: 'Cloudcraftz Solutions',
      position: 'Associate Software Developer',
      duration: 'Apr 2024 – Mar 2025',
      description:
          'Developed modular Flutter web apps with PDF generation and real-time sync, streamlining workflows for 100+ users.',
      achievements: [
        "Developed a modular assessment builder using Flutter Web with integrated PDF generation, streamlining assessment creation for 100+ users and reducing manual overhead.",
        "Architected a workflow management system in Flutter with GetX and Firebase Firestore, optimizing task routing and real-time sync to increase task handling speed by 40%.",
        "Engineered a multi-step form wizard in Flutter Web using BLoC and deployed via AWS, achieving 99.9% session continuity and a 20% boost in completion rates.",
      ],
    ),
    CareerItem(
      company: 'Fineant Consultant Services',
      position: 'Flutter Developer',
      duration: 'Aug 2023 – Feb 2024',
      description:
          'Built cross-platform mobile apps from scratch using Flutter and REST APIs, focusing on robust architecture and maintainable code.',
      achievements: [
        "Developed a cross-platform mobile app from scratch for photographer hiring and gift shopping, delivering a seamless experience across Android and iOS platforms.",
        "Implemented scalable state management using Provider and integrated REST APIs to ensure a robust, modular architecture with maintainable code structure.",
      ],
    ),
    CareerItem(
      company: 'Hosachiguru',
      position: 'Flutter Developer (Consultant)',
      duration: 'Oct 2022 – Jul 2023',
      description:
          'Led development of FarmOps and MyFarm apps, implementing offline-first functionality and improving app stability by 40%.',
      achievements: [
        "Led development of FarmOps, a Flutter-based farm management app for agronomists, improving field operations and productivity.",
        "Implemented real-time image uploads and advanced editing features using BLoC and Hive, streamlining reporting workflows and supporting offline-first functionality",
        "Redesigned core user flows and resolved critical bugs in the MyFarm app, increasing stability and leading to a 40% reduction in crash reports and improved user satisfaction.",
      ],
    ),
    CareerItem(
      company: 'Blackspektro',
      position: 'Mobile Application Developer',
      duration: 'Apr 2021 – Jul 2022',
      description: 'Integrated RESTful APIs and Developed a financial insights app',
      achievements: [
        "Integrated RESTful APIs and resolved performance issues, reducing UI lag and boosting app responsiveness across critical flows.",
        "Developed a financial insights app with real-time data visualization and pixel-perfect UI, using interactive charts and BLoC for robust and maintainable architecture.",
      ],
    ),
  ];
}
