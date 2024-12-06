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

  AddAddressEvent(
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

//! FETCH ADDRESS EVENT
class FetchAddressEvent extends AddressEvent {}
