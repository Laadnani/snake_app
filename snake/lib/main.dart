import 'package:flutter/material.dart';
import 'package:snake/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ('Snake'),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
