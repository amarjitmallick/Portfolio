import 'package:flutter/material.dart';

class ContactMobile extends StatefulWidget {
  @override
  _ContactMobileState createState() => _ContactMobileState();
}

class _ContactMobileState extends State<ContactMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.height / 1.2,
      color: Color(0xFF2D2E32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Information',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'RobotoMono',
                    fontSize: 10),
              ),
            ),
            Center(
              child: Text(
                "Let's make something\namazing together.",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RobotoMono',
                    fontSize: 15),
              ),
            ),
            Center(
              child: Text(
                "Start by saying hi",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RobotoMono',
                    fontSize: 15),
              ),
            ),
            Center(
              child: Text(
                'Email me:',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'RobotoMono',
                    fontSize: 20),
              ),
            ),
            Center(
              child: Text(
                "mallickamarjit@gmail.com",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'RobotoMono',
                    fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/twitter.png'),
                  backgroundColor: Colors.transparent,
                  radius: 15,
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/github.png'),
                  backgroundColor: Colors.transparent,
                  radius: 15,
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/linkedin.png'),
                  backgroundColor: Colors.transparent,
                  radius: 15,
                ),
                SizedBox(width: 20),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/instagram.png'),
                  backgroundColor: Colors.transparent,
                  radius: 15,
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Amarjit Mallick",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontFamily: 'RobotoMono',
                    fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
