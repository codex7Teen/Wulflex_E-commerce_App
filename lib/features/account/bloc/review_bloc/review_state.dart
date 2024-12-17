part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewAddedSuccess extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<EnhancedReviewModel> reviews;
  const ReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewError extends ReviewState {
  final String errorMessage;

  const ReviewError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
