import 'package:flutter/material.dart';

class MobileHeroSection extends StatelessWidget {
  final Function()? onTap;
  const MobileHeroSection({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Hi, I’m Amarjit, a Flutter Developer",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "I specialize in creating high-quality mobile applications using Flutter. With a passion for clean code and user-centric design, I bring ideas to life.",
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: const Color(0xFFDBE8F2)),
              onPressed: onTap,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  "View My Work",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
