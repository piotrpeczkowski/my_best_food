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
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                    Text(isCreatingAccount ? 'Zarejestruj się' : 'Zaloguj się'),
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
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isCreatingAccount == false) {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
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
                      }
                      if (isCreatingAccount == true) {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
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
                      }
                    },
                    child: Text(isCreatingAccount ? 'Zarejestruj' : 'Zaloguj'),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isCreatingAccount == false) {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  } else {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  }
                },
                child:
                    Text(isCreatingAccount ? 'Zaloguj się' : 'Zarejestruj się'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
