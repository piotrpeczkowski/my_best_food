import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_best_food/app/app.dart';
import 'package:my_best_food/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
