import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bloc/cart_bloc.dart';
import '../HiveTransaction/boxes.dart';
import '../HiveTransaction/transaction.dart';
import '../Item/fish_category.dart';

class NamingCubit extends Cubit<String> {

  NamingCubit() : super('') {
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('username');
    if (savedName != null) {
      emit(savedName);
    }
  }

  Future<void> saveUsername(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    emit(name);
  }


}
