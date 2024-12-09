import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

    // //! SEARCH PRODUCT BLOC
    // on<SearchProductEvent>((event, emit) {
    //   if (state is ProductLoaded) {
    //     final products = (state as ProductLoaded).products;
    //     if (event.query.isEmpty) {
    //       // show all products
    //       emit(ProductLoaded(products));
    //     }
    //     final filteredProducts = products.where((product) {
    //       return product.brandName
    //               .toLowerCase()
    //               .contains(event.query.toLowerCase()) ||
    //           product.name.toLowerCase().contains(event.query.toLowerCase()) ||
    //           product.description
    //               .toLowerCase()
    //               .contains(event.query.toLowerCase()) ||
    //           product.category
    //               .toLowerCase()
    //               .contains(event.query.toLowerCase());
    //     }).toList();

    //     emit(ProductLoaded(filteredProducts));
    //   }
    // });

    // //! SORT PRODUCT BLOC
    // on<SortProductEvent>((event, emit) {
    //   if (state is ProductLoaded) {
    //     final products = (state as ProductLoaded).products;
    //     List<ProductModel> sortedProducts = List.from(products);

    //     if (event.sortBy == 'Price: Low to High') {
    //       sortedProducts.sort((a, b) => a.offerPrice.compareTo(b.offerPrice));
    //     } else if (event.sortBy == 'Price: High to Low') {
    //       sortedProducts.sort((a, b) => b.offerPrice.compareTo(a.offerPrice));
    //     }

    //     emit(ProductLoaded(sortedProducts));
    //   }
    // });
  }
}
