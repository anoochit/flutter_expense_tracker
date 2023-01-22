import 'dart:developer';

import 'package:expense/const.dart';
import 'package:expense/controllers/app_comtroller.dart';
import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum ExpenseType { income, expense }

// ignore: must_be_immutable
class AddItemPage extends StatelessWidget {
  AddItemPage({super.key});

  ExpenseType? expenseType = ExpenseType.income;

  TextEditingController textDescription = TextEditingController();
  TextEditingController textPrice = TextEditingController();
  TextEditingController textAmount = TextEditingController();
  TextEditingController textDatetime = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add entry"),
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  // choose transaction type
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RadioListTile(
                          title: const Text("Income"),
                          value: ExpenseType.income,
                          groupValue: expenseType,
                          onChanged: (value) {
                            expenseType = value;
                            controller.update();
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RadioListTile(
                          title: const Text("Expense"),
                          value: ExpenseType.expense,
                          groupValue: expenseType,
                          onChanged: (value) {
                            expenseType = value;
                            controller.update();
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textDescription,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Description',
                        label: const Text('Description'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter description";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textAmount,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Amount',
                        label: const Text('Amount'),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter description";
                        } else if (int.tryParse(value)! < 0) {
                          return "Please enter positive value";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textDatetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintText: 'Date',
                        label: const Text('Date'),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter date";
                        }
                        return null;
                      },
                      onTap: () async {
                        // hide keyboard
                        FocusManager.instance.primaryFocus?.unfocus();
                        // show date picker
                        final datetime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().add(
                            const Duration(days: -30),
                          ),
                          lastDate: DateTime.now(),
                        );
                        if (datetime != null) {
                          final _datetime =
                              DateFormat("yyy-MM-DD").format(datetime);
                          textDatetime.text = _datetime;
                        }
                      },
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save_outlined),
                    label: const Text("Save entry"),
                    onPressed: () async {
                      // save entry
                      if (formKey.currentState!.validate()) {
                        final description = textDescription.text;
                        final amount = textAmount.text;
                        final datetime = textDatetime.text;
                        final key =
                            DateFormat("yyyMMddHHmm").format(DateTime.now());

                        final type =
                            ('${expenseType}'.contains('income') ? "i" : "e");

                        final item = Expense(
                          id: key,
                          type: type,
                          description: description,
                          amount: double.parse(amount),
                          datetime: DateTime.now(),
                        );

                        await expenseBox.put(key, item);
                        controller.getBalance();

                        Get.back();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
