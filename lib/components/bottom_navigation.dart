import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

import '../views/home_view.dart';
import '../views/settings_view.dart';

class BottomNavigation extends StatelessWidget {

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return FabCircularMenu(
      key: fabKey,
      // Cannot be `Alignment.center`
      alignment: Alignment.bottomRight,
      ringColor: primaryColor.withAlpha(25),
      ringDiameter: 400.0,
      ringWidth: 120.0,
      fabSize: 64.0,
      fabElevation: 8.0,

      // Also can use specific color based on wether
      // the menu is open or not:
      // fabOpenColor: Colors.white
      // fabCloseColor: Colors.white
      // These properties take precedence over fabColor
      fabColor: Colors.white,
      fabOpenIcon: Icon(Icons.scatter_plot, color: primaryColor),
      fabCloseIcon: Icon(Icons.close, color: primaryColor),
      fabMargin: const EdgeInsets.all(16.0),
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOutCirc,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            fabKey.currentState.close();
            Timer(Duration(milliseconds: 300), () {
              Navigator.popAndPushNamed(context, HomeView.id);
            });
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.home, color: primaryColor)),
        ),
        RawMaterialButton(
          onPressed: () {
            fabKey.currentState.close();
            Timer(Duration(milliseconds: 300), () {
              Navigator.popAndPushNamed(context, SettingsView.id);
            });
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.settings, color: primaryColor)),
        ),
      ],
    );
  }

}
