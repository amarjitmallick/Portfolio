import 'package:flutter/material.dart';
import 'package:portfolio/home_page.dart';
import 'package:portfolio/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amarjit Mallick | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (event) {
          setState(() {
            mousePosition = event.position;
          });
        },
        child: Stack(
          children: [
            const HomePage(),
            Positioned(
              left: mousePosition.dx - 50,
              top: mousePosition.dy - 50,
              child: IgnorePointer(
                child: CustomPaint(
                  size: const Size(60, 60),
                  painter: InvertedCursorPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvertedCursorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      30, // radius
      Paint()
        ..color = Colors.white
        ..blendMode = BlendMode.difference,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
