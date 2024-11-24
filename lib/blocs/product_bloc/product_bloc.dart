import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/models/product_model.dart';
import 'package:wulflex/services/product_services.dart';

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
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    //! LOAD LATEST PRODUCTS
    on<LoadLatestProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _productServices.getLatestProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    
  }
}
