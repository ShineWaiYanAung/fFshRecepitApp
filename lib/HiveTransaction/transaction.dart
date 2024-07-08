import 'package:hive/hive.dart';
import '../Item/fish_category.dart';
part 'transaction.g.dart';
@HiveType(typeId: 0)
class Transaction extends HiveObject{
  @HiveField(0)
  late DateTime createdDate;

  @HiveField(1)
  late List<FishName> invoice;
}