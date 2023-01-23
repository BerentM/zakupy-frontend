import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zakupy_frontend/data/api_service.dart';

import 'package:zakupy_frontend/l10n/l10n.dart';
import 'package:zakupy_frontend/view/home/home.dart';
import 'package:zakupy_frontend/view/router.dart';

void main() {
  runApp(App(appRouter: AppRouter()));
}

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      onGenerateRoute: appRouter.generateRoute,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ApiService(),
          ),
        ],
        child: Home(),
      ),
    );
  }
}
