part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

//! LOAD ALL CATEGORY DETAILS
class LoadAllCategoryDetailsEvent extends CategoryEvent {}
