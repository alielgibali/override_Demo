import 'package:flutter/material.dart';
import 'package:override_todo_demo/providers/spinner.dart';
import 'package:override_todo_demo/screens/auth.dart';
import 'package:override_todo_demo/screens/toDo_home.dart';
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
      ],
      child: MaterialApp(
        title: 'Overide ToDo Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthScreen(),
        routes: {
          ToDo.routeName: (_) => ToDo(),
        },
      ),
    );
  }
}
