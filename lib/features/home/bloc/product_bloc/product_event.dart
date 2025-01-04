part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

//! LOAD PRODUCT EVENT
class LoadProducts extends ProductEvent {}
