import 'package:expense/bindings/root_binding.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'const.dart';
import 'pages/add_item.dart';
import 'pages/home.dart';
import 'pages/settings.dart';
import 'themes/theme.dart';

Future<void> main() async {
  await Hive.initFlutter();
  // Register Adapter
  Hive.registerAdapter(ExpenseAdapter());
  // open box for expense
  expenseBox = await Hive.openBox<Expense>('expense');
  // open box for settings
  settingsBox = await Hive.openBox('settings');
  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
