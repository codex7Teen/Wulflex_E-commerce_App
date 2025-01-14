import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:wulflex/features/cart/bloc/address_bloc/address_bloc.dart';
import 'package:wulflex/features/cart/bloc/place_suggestion_bloc/place_suggestion_bloc.dart';
import 'package:wulflex/features/cart/presentation/widgets/add_address_screen_widgets.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/theme_data_helper_widget.dart';

class ScreenAddAddress extends StatefulWidget {
  const ScreenAddAddress({super.key});

  @override
  State<ScreenAddAddress> createState() => _ScreenAddAddressState();
}

class _ScreenAddAddressState extends State<ScreenAddAddress> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _areaNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _pincodeFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _houseFocusNode = FocusNode();
  final FocusNode _areaFocusNode = FocusNode();

  // Generate new tokens for each field that needs place suggestions
  final String areaToken = const Uuid().v4();
  final String cityToken = const Uuid().v4();
  final String stateToken = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
    _setupTextControllersListeners();
  }

  void _setupFocusListeners() {
    final focusNodes = [
      _nameFocusNode,
      _phoneFocusNode,
      _pincodeFocusNode,
      _houseFocusNode,
    ];

    for (var node in focusNodes) {
      node.addListener(() {
        if (node.hasFocus) {
          context.read<PlaceSuggestionBloc>().add(ClearSuggestionsEvent());
        }
      });
    }
  }

  void _setupTextControllersListeners() {
    // Area name listener
    _areaNameController.addListener(() {
      final bloc = context.read<PlaceSuggestionBloc>();
      final currentState = bloc.state;

      if (_areaNameController.text.isNotEmpty &&
          _areaFocusNode.hasFocus &&
          !currentState.isSelected) {
        bloc.add(FetchPlaceSuggestionsEvent(
            query: _areaNameController.text, sessionToken: areaToken));
      }
    });

    // City name listener
    _cityNameController.addListener(() {
      final bloc = context.read<PlaceSuggestionBloc>();
      final currentState = bloc.state;

      if (_cityNameController.text.isNotEmpty &&
          _cityFocusNode.hasFocus &&
          !currentState.isSelected) {
        bloc.add(FetchPlaceSuggestionsEvent(
            query: "${_cityNameController.text} city",
            sessionToken: cityToken));
      }
    });

    // State name listener
    _stateNameController.addListener(() {
      final bloc = context.read<PlaceSuggestionBloc>();
      final currentState = bloc.state;

      if (_stateNameController.text.isNotEmpty &&
          _stateFocusNode.hasFocus &&
          !currentState.isSelected) {
        bloc.add(FetchPlaceSuggestionsEvent(
            query: "${_stateNameController.text} state",
            sessionToken: stateToken));
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _pincodeController.dispose();
    _stateNameController.dispose();
    _cityNameController.dispose();
    _houseNameController.dispose();
    _areaNameController.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _pincodeFocusNode.dispose();
    _stateFocusNode.dispose();
    _cityFocusNode.dispose();
    _houseFocusNode.dispose();
    _areaFocusNode.dispose();
    super.dispose();
  }

  void _clearAllFields() {
    setState(() {
      _formKey.currentState?.reset();
      _nameController.clear();
      _phoneNumberController.clear();
      _pincodeController.clear();
      _stateNameController.clear();
      _cityNameController.clear();
      _houseNameController.clear();
      _areaNameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? AppColors.whiteThemeColor
          : AppColors.blackThemeColor,
      appBar: customAppbarWithBackbutton(context, 'ADD ADDRESS', 0.115),
      body: SingleChildScrollView(
        child: BlocListener<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressFailed) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Failed to add address!',
                  icon: Icons.error);
            } else if (state is AddressSuccess) {
              CustomSnackbar.showCustomSnackBar(
                  context, 'Address added successfully... 🎉🎉🎉');
              _clearAllFields();
              context.read<AddressBloc>().add(FetchAddressEvent());
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 14, left: 18, right: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddAddressScreenWidgets.buildNameText(context),
                  AddAddressScreenWidgets.buildNameTextfield(
                      context, _nameController, _nameFocusNode),
                  const SizedBox(height: 16),
                  AddAddressScreenWidgets.buildPhoneNumberText(context),
                  AddAddressScreenWidgets.buildPhoneNumberTextfield(
                      context, _phoneNumberController, _phoneFocusNode),
                  const SizedBox(height: 16),
                  AddAddressScreenWidgets.buildPincodeText(context),
                  AddAddressScreenWidgets.buildPincodeTextfield(
                      context, _pincodeController, _pincodeFocusNode),
                  const SizedBox(height: 16),
                  AddAddressScreenWidgets.buildStateandcityText(context),
                  AddAddressScreenWidgets.buildStateAndCityTextfield(
                      context,
                      _stateNameController,
                      _cityNameController,
                      _cityFocusNode,
                      _stateFocusNode),
                  BlocBuilder<PlaceSuggestionBloc, PlaceSuggestionState>(
                    builder: (context, state) {
                      if (state is PlaceSuggestionLoaded &&
                          state.suggestions.isNotEmpty) {
                        // Show state suggestions
                        if (_stateFocusNode.hasFocus && !state.isSelected) {
                          return _buildSuggestionsList(
                            state.suggestions,
                            (location) {
                              setState(() {
                                _stateNameController.text =
                                    _extractStateName(location['description']);
                              });
                              context.read<PlaceSuggestionBloc>().add(
                                    SelectSuggestedPlaceEvent(
                                        _stateNameController.text),
                                  );
                              FocusScope.of(context).unfocus();
                            },
                          );
                        }
                        // Show city suggestions
                        else if (_cityFocusNode.hasFocus && !state.isSelected) {
                          return _buildSuggestionsList(
                            state.suggestions,
                            (location) {
                              setState(() {
                                _cityNameController.text =
                                    _extractCityName(location['description']);
                              });
                              context.read<PlaceSuggestionBloc>().add(
                                    SelectSuggestedPlaceEvent(
                                        _cityNameController.text),
                                  );
                              FocusScope.of(context).unfocus();
                            },
                          );
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 16),
                  AddAddressScreenWidgets.buildHouseNameText(context),
                  AddAddressScreenWidgets.buildHouseNameTextfield(
                      context, _houseNameController, _houseFocusNode),
                  const SizedBox(height: 16),
                  AddAddressScreenWidgets.buildAreaNameText(context),
                  AddAddressScreenWidgets.buildAreaNameTextfield(
                    context,
                    _areaNameController,
                    _areaFocusNode,
                  ),
                  BlocBuilder<PlaceSuggestionBloc, PlaceSuggestionState>(
                    builder: (context, state) {
                      if (state is PlaceSuggestionLoaded &&
                          state.suggestions.isNotEmpty &&
                          _areaFocusNode.hasFocus &&
                          !state.isSelected) {
                        return _buildSuggestionsList(
                          state.suggestions,
                          (location) {
                            setState(() {
                              _areaNameController.text =
                                  _trimAddress(location['description']);
                            });
                            context.read<PlaceSuggestionBloc>().add(
                                  SelectSuggestedPlaceEvent(
                                      _areaNameController.text),
                                );
                            FocusScope.of(context).unfocus();
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      return AddAddressScreenWidgets.buildSaveButton(
                        context,
                        _formKey,
                        state,
                        _nameController,
                        _phoneNumberController,
                        _pincodeController,
                        _stateNameController,
                        _cityNameController,
                        _houseNameController,
                        _areaNameController,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsList(
    List<Map<String, dynamic>> suggestions,
    Function(Map<String, dynamic>) onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isLightTheme(context) ? Colors.grey[100] : Colors.grey[900],
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final location = suggestions[index];
          return _buildSuggestionItem(
            location,
            index == suggestions.length - 1,
            onTap,
          );
        },
      ),
    );
  }

  Widget _buildSuggestionItem(
    Map<String, dynamic> location,
    bool isLastItem,
    Function(Map<String, dynamic>) onTap,
  ) {
    return InkWell(
      onTap: () => onTap(location),
      child: Container(
        decoration: BoxDecoration(
          border: !isLastItem
              ? Border(
                  bottom: BorderSide(
                    color: isLightTheme(context)
                        ? Colors.grey[300]!
                        : Colors.grey[700]!,
                    width: 0.5,
                  ),
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color:
                    isLightTheme(context) ? Colors.grey[600] : Colors.grey[400],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  location['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        isLightTheme(context) ? Colors.black87 : Colors.white70,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _trimAddress(String address) {
    return address.length > 40 ? '${address.substring(0, 37)}...' : address;
  }

  String _extractStateName(String fullAddress) {
    // Extract state name from the full address
    // This is a simple implementation - you might want to enhance it based on your needs
    final parts = fullAddress.split(',');
    if (parts.length >= 2) {
      return parts[parts.length - 2].trim().replaceAll(' State', '');
    }
    return fullAddress;
  }

  String _extractCityName(String fullAddress) {
    // Extract city name from the full address
    // This is a simple implementation - you might want to enhance it based on your needs
    final parts = fullAddress.split(',');
    if (parts.isNotEmpty) {
      return parts[0].trim().replaceAll(' City', '');
    }
    return fullAddress;
  }
}
