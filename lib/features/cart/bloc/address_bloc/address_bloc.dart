import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wulflex/data/models/address_model.dart';
import 'package:wulflex/data/services/address_services.dart';

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
        // add address
        await _addressServices.addAddress(newAddress);

        // Fetch address immediately after adding
        final address = await _addressServices.fetchAddress();
        final selectedAddress = await _addressServices.getSelectedAddress();
        emit(AddressLoaded(address: address, selectedAddress: selectedAddress));
        emit(AddressSuccess());
        log('NEW ADDRESS ADDED');
      } catch (error) {
        emit(AddressFailed(errorMessage: error.toString()));
        log('ADDING ADDRESS GOT FAILED: $error');
      }
    });

    //! EDIT ADDRESS BLOC
    on<EditAddressEvent>((event, emit) async {
      emit(AddressLoading());
      try {
        // create address model with updated details
        final updatedAddress = AddressModel(
            id: event.addressId,
            name: event.name,
            phoneNumber: event.phoneNumber,
            pincode: event.phoneNumber,
            stateName: event.stateName,
            cityName: event.cityName,
            houseName: event.houseName,
            areaName: event.areaName);

        // update product in firebase
        await _addressServices.updateAddress(updatedAddress);

        //Fetch update address list
        final address = await _addressServices.fetchAddress();
        final selectedAddress = await _addressServices.getSelectedAddress();

        emit(AddressLoaded(address: address, selectedAddress: selectedAddress));
        emit(AddressSuccess());
        log('ADDRESS UPDATED SUCCESSFULLY');
      } catch (error) {
        emit(AddressFailed(errorMessage: error.toString()));
        log('UPDATING ADDRESS FAILED: $error');
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

    //! DELETE ADDRESS BLOC
    on<DeleteAddressEvent>((event, emit) async {
      emit(AddressLoading());
      try {
        await _addressServices.removeAddress(event.addressId);
        final updatedAddressList = await _addressServices.fetchAddress();
        emit(AddressDeletedSuccess());
        emit(AddressLoaded(address: updatedAddressList));
      } catch (error) {
        log('Delete Failed: $error');
        emit(AddressFailed(errorMessage: "Failed to delte address: $error"));
      }
    });
  }
}
