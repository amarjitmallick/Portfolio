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
      backgroundColor: Theme.of(context).primaryColor,
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
    );
  }
}
