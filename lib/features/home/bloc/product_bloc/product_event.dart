part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

//! LOAD PRODUCT EVENT
class LoadProducts extends ProductEvent {}

// //! SEARCH PRODUCT EVENT
// class SearchProductEvent extends ProductEvent {
//   final String query;

//   const SearchProductEvent(this.query);

//   @override
//   List<Object> get props => [query];
// }

// //! SORT PRODUCT EVENT
// class SortProductEvent extends ProductEvent {
//   final String sortBy;

//   SortProductEvent(this.sortBy);

//   @override
//   List<Object> get props => [sortBy];
// }
