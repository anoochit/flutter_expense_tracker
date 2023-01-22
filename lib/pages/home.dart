import 'package:expense/const.dart';
import 'package:expense/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      ),
      body: GetBuilder<AppController>(
        builder: (contoller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // balance
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text(
                    '${contoller.balance}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),

                // list transactions
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contoller.getEntryCount(),
                  itemBuilder: (context, index) {
                    final item = expenseBox.getAt(index);
                    return ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: (item.type == 'i') ? Colors.green : Colors.red,
                      ),
                      title: Text('${item.description}'),
                      trailing: Text('${item.amount}'),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
