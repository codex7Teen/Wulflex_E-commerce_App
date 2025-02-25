part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

//! ADD ADDRESS EVENT
class AddAddressEvent extends AddressEvent {
  final String name;
  final String phoneNumber;
  final String pincode;
  final String stateName;
  final String cityName;
  final String houseName;
  final String areaName;

  const AddAddressEvent(
      {required this.name,
      required this.phoneNumber,
      required this.pincode,
      required this.stateName,
      required this.cityName,
      required this.houseName,
      required this.areaName});

  @override
  List<Object> get props =>
      [name, phoneNumber, pincode, stateName, cityName, houseName, areaName];
}

//! EDIT ADDRESS EVENT
class EditAddressEvent extends AddressEvent {
  final String addressId;
  final String name;
  final String phoneNumber;
  final String pincode;
  final String stateName;
  final String cityName;
  final String houseName;
  final String areaName;

  const EditAddressEvent(
      {required this.addressId,
      required this.name,
      required this.phoneNumber,
      required this.pincode,
      required this.stateName,
      required this.cityName,
      required this.houseName,
      required this.areaName});

  @override
  List<Object> get props => [
        addressId,
        name,
        phoneNumber,
        pincode,
        stateName,
        cityName,
        houseName,
        areaName
      ];
}

//! FETCH ADDRESS EVENT
class FetchAddressEvent extends AddressEvent {}

//! SELECT ADDRESS EVENT
class SelectAddressEvent extends AddressEvent {
  final AddressModel address;

  const SelectAddressEvent({required this.address});

  @override
  List<Object> get props => [address];
}

//! DELETE ADDRESS EVENT
class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  const DeleteAddressEvent({required this.addressId});

  @override
  List<Object> get props => [addressId];
}
