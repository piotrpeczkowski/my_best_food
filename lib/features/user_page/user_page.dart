import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_best_food/features/user_page/cubit/user_cubit.dart';
import 'package:my_best_food/repositories/user_repository.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    // required this.userEmail,
    Key? key,
  }) : super(key: key);

  // final userEmail;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? _userName;
  String? _userCity;
  String? _userGender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(UserRepository()),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Edytuj profil'),
                actions: [
                  IconButton(
                    onPressed: _userName == null ||
                            _userCity == null ||
                            _userGender == null
                        ? null
                        : () {
                            // context.read<UserCubit>().update(
                            //       _dateTime,
                            //       _restaurant!,
                            //       _food!,
                            //       _price!,
                            //       _rank!,
                            //     );
                          },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
              body: const _UserPageBody(),
            );
          },
        ),
      ),
    );
  }
}

class _UserPageBody extends StatelessWidget {
  const _UserPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
