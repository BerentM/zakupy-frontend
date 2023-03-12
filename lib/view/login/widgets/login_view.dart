import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:zakupy_frontend/view/login/cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.popAndPushNamed(context, HOME);
            }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state is LoginInitial) {
            return ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.username,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.password,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgot_password,
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.login),
                      onPressed: () {
                        context.read<LoginCubit>().getToken(
                              nameController.text,
                              passwordController.text,
                            );
                        Navigator.pop(context, true);
                        Navigator.popAndPushNamed(context, HOME);
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_account),
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.sign_in,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            );
          }
          return const Scaffold();
        },
      ),
    );
  }
}
