import 'package:flutter/material.dart';
import 'package:override_todo_demo/providers/spinner.dart';
import 'package:override_todo_demo/providers/theme.dart';
import 'package:override_todo_demo/screens/auth.dart';
import 'package:override_todo_demo/screens/general.dart';
import 'package:override_todo_demo/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Loading(),
        ),
        ChangeNotifierProvider.value(
          value: ThemeChanger(),
        ),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
        title: 'Overide ToDo Demo',
        theme: theme.isLight ? ThemeData.light() : ThemeData.dark(),
        home: AuthScreen(),
        routes: {
          CreatToDo.routeName: (_) => CreatToDo(),
        });
  }
}
