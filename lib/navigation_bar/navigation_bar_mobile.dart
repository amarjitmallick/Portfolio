import 'package:flutter/material.dart';
import 'package:portfolio/utilities/constants.dart';

class NavigationBarMobile extends StatefulWidget {
  @override
  _NavigationBarMobileState createState() => _NavigationBarMobileState();
}

class _NavigationBarMobileState extends State<NavigationBarMobile> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      collapsedHeight: 80,
      floating: true,
      snap: true,
      pinned: false,
      backgroundColor: kPrimaryColor,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20),
          child: IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.green,
            ),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ),
      ],
      title: Padding(
        padding: const EdgeInsets.only(left: 8, top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Amarjit',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Mallick',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'RobotoMono',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
