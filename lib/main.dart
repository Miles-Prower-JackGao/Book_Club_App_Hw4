import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'blocs/authentication_bloc.dart';
import 'router/app_router.dart';

void main() {
  final authBloc = AuthenticationBloc();
  final router = createRouter(authBloc);
  runApp(
    BlocProvider.value(
      value: authBloc,
      child: MyApp(router: router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    return MaterialApp.router(
      title: 'Book Club',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surfaceContainer,
          centerTitle: true,
        ),
      ),
      routerConfig: router,
    );
  }
}


