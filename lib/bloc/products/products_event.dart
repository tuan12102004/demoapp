part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent extends Equatable{}
class AddProducts extends ProductsEvent{
  final Breads products;
   AddProducts({required this.products});
  @override
  List<Object?> get props => [products];
}
class RemoveProducts extends ProductsEvent{
  final Breads products;
  RemoveProducts({required this.products});
  @override
  List<Object?> get props => [products];
}
class ResetProductQuantity extends ProductsEvent {
  final Breads products;

  ResetProductQuantity({required this.products});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
