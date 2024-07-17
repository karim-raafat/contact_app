import 'package:contact_app/pages/all_contacts_page.dart';
import 'package:contact_app/pages/contact_details.dart';
import 'package:contact_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            fillColor: Colors.grey[300],
            filled: true,
            outlineBorder: BorderSide.none,
            border: OutlineInputBorder()),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
          path: LoginPage.routeName,
          name: LoginPage.routeName,
          builder: (context, state) => LoginPage(),
          routes: [
            GoRoute(
                path: AllContactsPage.routeName,
                name: AllContactsPage.routeName,
                builder: (context, state) => AllContactsPage(),
                routes: [
                  GoRoute(
                    path: ContactDetailsPage.routeName,
                    name: ContactDetailsPage.routeName,
                    builder: (context,state) => ContactDetailsPage()
                  ),
                ]),
          ]),
    ],
  );
}
