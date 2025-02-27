import 'widgets/grocery_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.deepPurple,
            surface:  Colors.black,
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 12, 4, 103)),
      home: const GroceryList(),
    );
  }
}
