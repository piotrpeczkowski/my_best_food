import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Zaloguj się'),
              ),
              // EMAIL TextField
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                ),
              ),
              // PASSWORD TextField
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: TextField(
                  controller: widget.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Hasło'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 4),
                          backgroundColor: Colors.red,
                          content: Text('$error'),
                        ),
                      );
                    }
                  },
                  child: const Text('Zaloguj'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
