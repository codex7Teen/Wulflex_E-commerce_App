import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/data/models/enhanced_review_model.dart';
import 'package:wulflex/data/models/review_model.dart';
import 'package:wulflex/data/services/review_services.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewServices _reviewServices;
  final FirebaseAuth _firebaseAuth;
  ReviewBloc(this._reviewServices, this._firebaseAuth)
      : super(ReviewInitial()) {
    //! ADD REVIEW BLOC
    on<AddReviewEvent>((event, emit) async {
      emit(ReviewLoading());
      try {
        // Review to add
        final reviewToAdd = ReviewModel(
            userId: _firebaseAuth.currentUser!.uid,
            productId: event.review.productId,
            rating: event.review.rating,
            tags: event.review.tags,
            selectedSizeOrWeight: event.review.selectedSizeOrWeight,
            reviewText: event.review.reviewText,
            createdAt: DateTime.now());

        await _reviewServices.addReview(reviewToAdd);
        emit(ReviewAddedSuccess());
        log('BLOC: NEW REVIEW ADDED');
      } catch (error) {
        log('BLOC: REVIEW ADDING FAILED : $error');
        emit(ReviewError(error.toString()));
      }
    });

    //! FETCH REVIEW BLOC
    on<FetchProductReviewsEvent>((event, emit) async {
      emit(ReviewLoading());
      try {
        final reviewStream = _reviewServices.getProductReviewsWithUserDetails(event.productId);
        log('BLOC: REVIEWS LOADED');
        await for (var reviews in reviewStream) {
          emit(ReviewsLoaded(reviews));
        }
      } catch (error) {
        log('BLOC: REVIEWS ERROR $error');
        emit(ReviewError(error.toString()));
      }
    });
  }
}
