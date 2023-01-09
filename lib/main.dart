import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_best_food/features/auth/permission_page/permission_page.dart';
import 'package:my_best_food/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PermissionPage(),
    );
  }
}
