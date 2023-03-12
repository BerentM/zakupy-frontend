import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zakupy_frontend/constants/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakupy_frontend/view/home/cubit/home_cubit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var component = "home screen";

  List<Widget> buildChildren(BuildContext context, bool loggedIn) {
    var builder = [
      Text(AppLocalizations.of(context)!.home),
      ElevatedButton(
        onPressed: loggedIn
            ? (() => Navigator.pushNamed(context, SHOPPING_LIST))
            : null,
        child: Text(AppLocalizations.of(context)!.shopping_list),
      ),
      Center(
        child: ElevatedButton(
          onPressed: loggedIn
              ? (() => Navigator.pushNamed(context, PRODUCT_LIST))
              : null,
          child: Text(AppLocalizations.of(context)!.product_list),
        ),
      ),
    ];
    if (loggedIn) {
      builder.add(
        Center(
          child: ElevatedButton(
            onPressed: (() {
              context.read<HomeCubit>().logOut();
              Navigator.pop(context, true);
              Navigator.popAndPushNamed(context, HOME);
            }),
            child: Text(AppLocalizations.of(context)!.log_out),
          ),
        ),
      );
    } else {
      builder.add(
        Center(
          child: ElevatedButton(
            onPressed: (() => Navigator.pushNamed(context, LOGIN)),
            child: Text(AppLocalizations.of(context)!.login),
          ),
        ),
      );
    }

    return builder;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            context.read<HomeCubit>().checkJwt();
          }
          if (state is HomeLoggedIn) {
            return Scaffold(
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildChildren(context, true)),
            );
          }
          if (state is HomeLoggedOut) {
            return Scaffold(
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildChildren(context, false)),
            );
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }
}
