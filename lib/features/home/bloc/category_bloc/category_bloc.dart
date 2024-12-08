import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/data/services/category_services.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryServices _categoryServices;
  CategoryBloc(this._categoryServices) : super(CategoryInitial()) {
    //! LOAD ALL CATEGORY DETAILS BLOC
    on<LoadAllCategoryDetailsEvent>((event, emit) async {
      try {
        emit(CategoryLoading());
        final categoryDetails = await _categoryServices.getAllCategoryDetails();
        emit((CategoryDetailsLoaded(categoryDetails: categoryDetails)));
      } catch (error) {
        emit(CategoryError(
            errorMessage: 'Failed to load category details: $error'));
      }
    });
  }
}
