import 'package:flutter/material.dart';
import 'package:phone_app_flutter/list.dart';

/**
 * phone_app_flutter
 * FileName : main
 * Class: main.
 * Created by 김승룡.
 * Created On 2025-03-12.
 * Description: main App
 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'phone_app_flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // home: const Placeholder(),
      initialRoute: "/",
      routes: {
        "/": (context) => PhoneAppList(),
        //   "/write": (content) => WriteForm(),
        //   "/edit": (context) => EditForm(),
      },
    );
  }
}
