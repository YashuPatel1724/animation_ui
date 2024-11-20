import 'package:flutter/material.dart';

import 'Darg and Drop/home_page.dart';
import 'animation align and container/first_task.dart';

void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlaneAnimationPage(),
    );
  }
}
