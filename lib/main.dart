import 'package:apiapp/routes.dart';
import 'package:apiapp/theme.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void toggleDatkmode(bool newState) {
    setState(() {
      isDark = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo API',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      // ),
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      // initialRoute: Home.routeName,
      routes: routes,
      home: Home(
        isDark: isDark,
        toggleDatkmode: toggleDatkmode,
      ),
    );
  }
}
