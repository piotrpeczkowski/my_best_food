import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_best_food/features/auth/login_page/login_page.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return LoginPage();
          }
          // TODO create Home Page
          return LoginPage();
        });
  }
}
