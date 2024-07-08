import 'package:hive/hive.dart';
import 'package:kg6_project/HiveTransaction/transaction.dart';

class Boxes {
  static Box<Transaction> getTransactions() =>
      Hive.box<Transaction>('invoice');
}
