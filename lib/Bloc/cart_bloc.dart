import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../HiveTransaction/boxes.dart';
import '../HiveTransaction/transaction.dart';
import '../Item/fish_category.dart';

part "cart_event.dart";
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent,CartState> {
  CartBloc() : super(CartState([])) {
    on<CartEvent>(_addtoCartEmit);
  }
  Future<void> _addtoCartEmit(CartEvent event, Emitter<CartState> emit) async {
    if (event is CartIncrement) {
      final updateCart = List<FishName>.from(state.cartItems)..add(event.items);
      emit(CartState(updateCart));
      print(updateCart);
    }

    if (event is CartDecrement) {
      final updateCart = List<FishName>.from(state.cartItems)..remove(event.items);
      emit(CartState(updateCart));
      print(updateCart);
    }

  }
  Future<void> addTranscation(List<FishName>items,)async{
    // final transaction = Transaction();
    // transaction.invoice = items;
    // transaction.createdDate = DateTime.now();

    final transaction =  Transaction()
      ..invoice = items
      ..createdDate= DateTime.now();
    final box = Boxes.getTransactions();
    box.add(transaction);
    emit(CartState([]));
    print("Cart state reset ${state.cartItems}");
    print("${transaction.invoice}");



  }
  void deleteTransaction(Transaction transaction) {
    transaction.delete();
  }

}
