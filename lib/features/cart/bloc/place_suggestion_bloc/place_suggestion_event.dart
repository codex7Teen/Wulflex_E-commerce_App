part of 'place_suggestion_bloc.dart';

abstract class PlaceSuggestionEvent extends Equatable {
  const PlaceSuggestionEvent();

  @override
  List<Object> get props => [];
}

class FetchPlaceSuggestionsEvent extends PlaceSuggestionEvent {
  final String query;
  final String sessionToken;

  const FetchPlaceSuggestionsEvent(
      {required this.query, required this.sessionToken});

  @override
  List<Object> get props => [query, sessionToken];
}


class ClearSuggestionsEvent extends PlaceSuggestionEvent {}

class SelectSuggestedPlaceEvent extends PlaceSuggestionEvent {
  final String address;

  const SelectSuggestedPlaceEvent(this.address);

    @override
  List<Object> get props => [address];
}