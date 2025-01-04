part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryError extends CategoryState {
  final String errorMessage;

  const CategoryError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class CategoryDetailsLoaded extends CategoryState {
  final List<Map<String, dynamic>> categoryDetails;
  
  const CategoryDetailsLoaded({required this.categoryDetails});
  
  @override
  List<Object> get props => [categoryDetails];
}
