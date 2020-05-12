import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/theme_controller.dart';

import '../models/theme_model.dart';

import '../components/bottom_navigation.dart';

class SettingsView extends StatefulWidget {
  static const String id = 'SettingsView';
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  ThemeController _themeController;

  @override
  void didChangeDependencies() {
    _themeController = Provider.of<ThemeController>(context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Settings'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose Theme'),
            ListTile(
              title: Text('Light Theme'),
              leading: Radio(
                value: ThemeOption.light,
                groupValue: _themeController.currentTheme,
                onChanged: (String selection){
                  setState(() {
                    _themeController.setTheme(selection);
                    print(selection);
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Dark Theme'),
              leading: Radio(
                value: ThemeOption.dark,
                groupValue: _themeController.currentTheme,
                onChanged: (String selection){
                  setState(() {
                    _themeController.setTheme(selection);
                    print(selection);
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BottomNavigation(),
    );
  }
}
