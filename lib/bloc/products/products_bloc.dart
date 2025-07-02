import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/bread_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsStates> {
  ProductsBloc() : super(ProductsStates()) {
    on<AddProducts>(addProducts);
    on<RemoveProducts>(removeProducts);
    on<ResetProductQuantity>(resetProducts);
  }
  void resetProducts(ResetProductQuantity event, Emitter<ProductsStates> emit) {
    final updatedProducts = state.products.map((product) {
      if (product.breadId == event.products.breadId) {
        return product.copyWith(quantity: 1);
      }
      return product;
    }).toList();

    emit(state.copyWith(products: updatedProducts));
  }
 void addProducts(AddProducts event, Emitter<ProductsStates> emit){
     final List<Breads> index = List.from(state.products);
     final products = index.indexWhere((products) {
       return products.breadId == event.products.breadId;
     },);
     if(products != -1){
       final add = index[products];
       index[products] = add.copyWith(quantity: add.quantity + 1);
     }else{
       index.add(event.products.copyWith(quantity: 1));
     }
     emit(state.copyWith(products: index));
 }
  void removeProducts(RemoveProducts event, Emitter<ProductsStates> emit) {
    final List<Breads> index = List.from(state.products);
    final update = index.indexWhere((products) =>
    products.breadId == event.products.breadId);

    if (update != -1) {
      final remove = index[update];
      final newQuantity = remove.quantity - 1;

      if (newQuantity > 0) {
        index[update] = remove.copyWith(quantity: newQuantity);
      } else {
        index.removeAt(update);
      }

      emit(state.copyWith(products: index));
    }
  }
}

