import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'gui/spalsh_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Welcome(),
        title: 'Product App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

      ),
    );
  }
}


