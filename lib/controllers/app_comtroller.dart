import 'dart:developer';

import 'package:expense/models/expense.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class AppController extends GetxController {
  RxDouble balance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    addMockupData();
    getBalance();
  }

  // init hive box
  Future<void> initBox() async {}

  // add mockup data
  addMockupData() async {
    final total = expenseBox.values;
    log('total = ${total.length}');

    if (total.isEmpty) {
      final id = DateFormat("yyyMMddHHmm").format(DateTime.now());
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
    double _balance = 0;
    for (var element in expenseBox.values) {
      if (element.type == "i") {
        //log('income = ${element.amount}');
        _balance = _balance + element.amount;
      } else {
        //log('expense = ${element.amount}');
        _balance = _balance + (element.amount * -1);
      }
    }
    log('balance = $_balance');
    balance.value = _balance;
    update();
  }

  // get entry
  int getEntryCount() {
    if (balance != 0) {
      return expenseBox.values.length;
    } else {
      return 0;
    }
  }
}
