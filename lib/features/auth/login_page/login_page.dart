import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/auth/login_page/cubit/login_cubit.dart';
import 'package:my_best_food/repositories/auth_repository.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepository()),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(isCreatingAccount
                          ? 'Zarejestruj się'
                          : 'Zaloguj się'),
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
                    // CONFIRM PASSWORD TextField
                    Column(
                      children: [
                        if (isCreatingAccount == true) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextField(
                              controller: widget.confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Potwierdź Hasło'),
                            ),
                          ),
                        ]
                      ],
                    ),
                    // REGISTER and LOGIN ElevatedButton
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            // LOGIN statement
                            if (isCreatingAccount == false) {
                              try {
                                context.read<LoginCubit>().signIn(
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
                            // REGISTER statement
                            if (isCreatingAccount == true) {
                              if (widget.passwordController.text ==
                                  widget.confirmPasswordController.text) {
                                try {
                                  context.read<LoginCubit>().register(
                                        email: widget.emailController.text,
                                        password:
                                            widget.passwordController.text,
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
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 4),
                                    backgroundColor: Colors.red,
                                    content: Text('Password not match'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                              isCreatingAccount ? 'Zarejestruj' : 'Zaloguj'),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        // RESET PASSWORD button
                        if (isCreatingAccount == false) ...[
                          TextButton(
                            onPressed: () {
                              try {
                                context.read<LoginCubit>().resetPassword(
                                      email: widget.emailController.text.trim(),
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
                            child: const Text('Nie pamiętasz hasła?'),
                          ),
                        ],
                        // LOGIN - REGISTER switch
                        TextButton(
                          onPressed: () {
                            if (isCreatingAccount == false) {
                              setState(() {
                                isCreatingAccount = true;
                                widget.emailController.text = '';
                                widget.passwordController.text = '';
                              });
                            } else {
                              setState(() {
                                isCreatingAccount = false;
                                widget.emailController.text = '';
                                widget.passwordController.text = '';
                              });
                            }
                          },
                          child: Text(isCreatingAccount
                              ? 'Zaloguj się'
                              : 'Zarejestruj się'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
