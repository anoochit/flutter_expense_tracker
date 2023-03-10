import 'dart:developer';

import 'package:expense/models/expense.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class AppController extends GetxController {
  RxDouble balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initBox().then(
      (value) {
        addMockupData();
        getBalance();
      },
    );
  }

  // init hive box
  Future<void> initBox() async {
    await Hive.initFlutter();
    // Register Adapter
    Hive.registerAdapter(ExpenseAdapter());
    // open box for expense
    expenseBox = await Hive.openBox<Expense>('expense');
    // open box for settings
    settingsBox = await Hive.openBox('settings');
  }

  // add mockup data
  addMockupData() async {
    final total = expenseBox.values;
    log('total = ${total.length}');

    if (total.isEmpty) {
      final id = DateFormat("yyyMMddHHmmss").format(DateTime.now());
      final item = Expense(
        id: id,
        type: "i",
        description: "sell goods",
        amount: 500,
        datetime: DateTime.now(),
      );
      await expenseBox.put(id, item);
    }
    update();
  }

  // get balance
  getBalance() {
    double total = 0;
    for (var element in expenseBox.values) {
      if (element.type == "i") {
        //log('income = ${element.amount}');
        total = total + element.amount;
      } else {
        //log('expense = ${element.amount}');
        total = total + (element.amount * -1);
      }
    }
    log('balance = $total');
    balance.value = total;
    update();
  }

  // get entry
  int getEntryCount() {
    if (balance.value != 0) {
      return expenseBox.values.length;
    } else {
      return 0;
    }
  }
}
