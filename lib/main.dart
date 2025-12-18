import 'package:flutter/material.dart';
import 'package:remindbless/core/go_router.dart';
import 'package:remindbless/core/path_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PathRouter.rootScreen,
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
