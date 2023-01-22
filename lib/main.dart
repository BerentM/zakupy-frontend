import 'package:flutter/material.dart';

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
    );
  }
}
