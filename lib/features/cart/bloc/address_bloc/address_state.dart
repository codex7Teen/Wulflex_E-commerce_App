part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressSuccess extends AddressState {}

final class AddressDeletedSuccess extends AddressState {}

final class AddressFailed extends AddressState {
  final String errorMessage;

  AddressFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

//! ADDRESS LOADED STATE
final class AddressLoaded extends AddressState {
  final List<AddressModel> address;
  final AddressModel? selectedAddress;

  AddressLoaded({required this.address, this.selectedAddress});

  @override
  List<Object> get props => [address, selectedAddress ?? ''];

  AddressLoaded copyWith({
    List<AddressModel>? address,
    AddressModel? selectedAddress,
  }) {
    return AddressLoaded(
        address: address ?? this.address,
        selectedAddress: selectedAddress ?? this.selectedAddress);
  }
}
