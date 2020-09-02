import 'package:flutter/material.dart';
import 'package:todo_app/managers/todo_manager.dart';
import 'package:todo_app/screens/todo_home_screen.dart';

import 'managers/Routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Routes.createRoutes();
  ToDoManager.readToDoItems().then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.greenAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      home: ToDoHomeScreen(),
    );
  }
}