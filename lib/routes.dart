import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/theme_controller.dart';

import 'views/home_view.dart';
import 'views/settings_view.dart';

class Routes extends StatefulWidget {
  static const String id = 'Routes';
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  ThemeController _themeController;

  @override
  void didChangeDependencies(){
    _themeController = Provider.of<ThemeController>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: _themeController.themeData,
      initialRoute: HomeView.id,
      routes: {
        HomeView.id : (context) => HomeView(),
        SettingsView.id: (context) => SettingsView(),
      },
    );
  }
}
