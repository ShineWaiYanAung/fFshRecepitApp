import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
<<<<<<< HEAD
    if (event is CartDecrement) {
      final updateCart = List<FishName>.from(state.cartItems)..remove(event.items);
      emit(CartState(updateCart));
      print(updateCart);
    }
=======
>>>>>>> origin/master
  }
}
