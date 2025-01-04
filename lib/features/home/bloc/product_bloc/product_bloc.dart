import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/models/product_model.dart';
import 'package:wulflex/data/services/product_services.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductServices _productServices;
  ProductBloc(this._productServices) : super(ProductInitial()) {
    //! LOAD PRODUCTS
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        await emit.forEach(
          _productServices.getProducts(),
          onData: (List<ProductModel> products) => ProductLoaded(products),
          onError: (error, stackTrace) => ProductError(error.toString()),
        );
        log('PRODUCT LOADED');
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
