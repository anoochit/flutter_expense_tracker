import 'package:expense/bindings/root_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/add_item.dart';
import 'pages/home.dart';
import 'pages/settings.dart';
import 'themes/theme.dart';

Future<void> main() async {
  // run app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //showSemanticsDebugger: true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: kDefaultTheme,
      home: const HomePage(),
      initialBinding: RootBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/add',
          page: () => AddItemPage(),
          fullscreenDialog: true,
        ),
        GetPage(
          name: '/settings',
          page: () => const SettingsPage(),
        )
      ],
    );
  }
}
