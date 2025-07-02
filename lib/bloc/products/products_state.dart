part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

 class ProductsStates extends Equatable {
  List<Breads> products;
  ProductsStates({ this.products = const []});
  ProductsStates copyWith({ List<Breads>? products}){
    return ProductsStates(
      products: products ?? this.products,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [products];

}
