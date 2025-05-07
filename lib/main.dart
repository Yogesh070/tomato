import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const TomatoApp()));
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomato App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Text('Tomato App'),
    );
  }
}
    );
  }
}
