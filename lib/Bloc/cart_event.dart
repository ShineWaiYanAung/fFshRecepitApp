part of 'cart_bloc.dart';

class CartEvent extends Equatable{
  @override

  List<Object?> get props => [];
}

class CartIncrement extends CartEvent{
  FishName  items;
  CartIncrement(this.items);
  List<Object?> get props => [items];
}
class CartDecrement extends CartEvent{
  FishName items;
  CartDecrement(this.items);
  List<Object?> get props => [items];

}


