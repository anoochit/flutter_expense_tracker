import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1, defaultValue: 'i')
  String type;
  @HiveField(2)
  String description;
  @HiveField(3, defaultValue: 0.0)
  double amount;
  @HiveField(4)
  DateTime datetime;
  Expense({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.datetime,
  });
}
