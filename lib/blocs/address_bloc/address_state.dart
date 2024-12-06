part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressSuccess extends AddressState {}

final class AddressFailed extends AddressState {
  final String errorMessage;

  AddressFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class AddressLoaded extends AddressState {
  final List<AddressModel> address;

  AddressLoaded({required this.address});

  @override
  List<Object> get props => [address];
}
