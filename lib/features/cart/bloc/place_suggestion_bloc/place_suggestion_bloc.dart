import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/services/place_api_services.dart';

part 'place_suggestion_event.dart';
part 'place_suggestion_state.dart';

class PlaceSuggestionBloc
    extends Bloc<PlaceSuggestionEvent, PlaceSuggestionState> {
  final PlaceApiServices _apiService;
  PlaceSuggestionBloc(this._apiService)
      : super(const PlaceSuggestionInitial()) {
    on<FetchPlaceSuggestionsEvent>(_onFetchSuggestions);
    on<ClearSuggestionsEvent>(_onClearSuggestions);
    on<SelectSuggestedPlaceEvent>(_onSelectAddress);
  }

  Future<void> _onFetchSuggestions(
    FetchPlaceSuggestionsEvent event,
    Emitter<PlaceSuggestionState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const PlaceSuggestionInitial());
      return;
    }

    emit(PlaceSuggestionLoading());

    try {
      final suggestions = await _apiService.getSuggestions(
        event.query,
        event.sessionToken,
      );
      emit(PlaceSuggestionLoaded(suggestions));
    } catch (error) {
      emit(PlaceSuggestionError(error.toString()));
    }
  }

  Future<void> _onClearSuggestions(
    ClearSuggestionsEvent event,
    Emitter<PlaceSuggestionState> emit,
  ) async {
    emit(const PlaceSuggestionInitial());
  }

  void _onSelectAddress(
    SelectSuggestedPlaceEvent event,
    Emitter<PlaceSuggestionState> emit,
  ) {
    // First emit the selected state
    emit(PlaceSuggestionSelected(event.address));
    // Then clear the suggestions
    emit(const PlaceSuggestionLoaded([]));
  }
}
