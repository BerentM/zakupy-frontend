import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zakupy_frontend/view/login/cubit/login_cubit.dart';
import 'package:zakupy_frontend/view/login/widgets/login_view.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginView(),
    );
  }
}
