import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';


import 'controllers/theme_controller.dart';
import 'controllers/todo_list_controller.dart';

import 'routes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  final Box<dynamic> db = await Hive.openBox('appDB');

  runApp(MyApp(database: db));
}

class MyApp extends StatelessWidget {
  final Box<dynamic> database;

  MyApp({this.database});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoListController(database)),
        ChangeNotifierProvider(create: (_) => ThemeController(database)),
      ],
      child: Routes(),
    );
  }
}
