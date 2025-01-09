part of 'place_suggestion_bloc.dart';

abstract class PlaceSuggestionState extends Equatable {
  final List<Map<String, dynamic>> suggestions;
  final bool isSelected;
  final String selectedPlace;
  const PlaceSuggestionState({
    this.suggestions = const [],
    this.isSelected = false,
    this.selectedPlace = '',
  });

  @override
  List<Object> get props => [suggestions, isSelected, selectedPlace];
}

final class PlaceSuggestionInitial extends PlaceSuggestionState {
  const PlaceSuggestionInitial() : super();
}

class PlaceSuggestionLoading extends PlaceSuggestionState {
  PlaceSuggestionLoading() : super(suggestions: []);
}

class PlaceSuggestionLoaded extends PlaceSuggestionState {
  const PlaceSuggestionLoaded(List<Map<String, dynamic>> suggestions)
      : super(suggestions: suggestions);
}

class PlaceSuggestionSelected extends PlaceSuggestionState {
  PlaceSuggestionSelected(String address)
      : super(isSelected: true, selectedPlace: address, suggestions: []);
}

class PlaceSuggestionError extends PlaceSuggestionState {
  final String error;

  PlaceSuggestionError(this.error) : super(suggestions: []);
}
