import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/models/address_model.dart';
import 'package:wulflex/services/address_services.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressServices _addressServices;
  AddressBloc(this._addressServices) : super(AddressInitial()) {
    //! ADD ADDRESS BLOC
    on<AddAddressEvent>((event, emit) async {
      emit(AddressLoading());
      try {
        // create  address model
        final newAddress = AddressModel(
            name: event.name,
            phoneNumber: event.phoneNumber,
            pincode: event.pincode,
            stateName: event.stateName,
            cityName: event.cityName,
            houseName: event.houseName,
            areaName: event.areaName);

        await _addressServices.addAddress(newAddress);
        emit(AddressSuccess());
        log('NEW ADDRESS ADDED');
      } catch (error) {
        emit(AddressFailed(errorMessage: error.toString()));
        log('ADDING ADDRESS GOT FAILED: $error');
      }
    });

    //! FETCH ADDRESS BLOC
    on<FetchAddressEvent>((event, emit) async {
      emit(AddressLoading());
      try {
        final address = await _addressServices.fetchAddress();
        final selectedAddress = await _addressServices.getSelectedAddress();
        emit(AddressLoaded(address: address, selectedAddress: selectedAddress));
        log('Address fetched successfully');
      } catch (error) {
        emit(AddressFailed(errorMessage: error.toString()));
        log('Failed to fetch address: $error');
      }
    });

    //! SELECT ADDRESS BLOC
    on<SelectAddressEvent>((event, emit) async {
      final currentState = state;
      if (currentState is AddressLoaded) {
        // Save selected address to firestore
        await _addressServices.saveSelectedAddress(event.address);
        emit(currentState.copyWith(selectedAddress: event.address));
      }
    });
  }
}
