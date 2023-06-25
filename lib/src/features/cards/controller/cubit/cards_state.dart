// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cards_bloc.dart';

class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object> get props => [];
}

class CollectionState extends CardsState {
  final RequestState requestState;
  final String errorMessage;
  final List<FlashcardCollection> collections;
  const CollectionState({
    this.requestState = RequestState.loading,
    this.errorMessage = '',
    this.collections = const [],
  });

  CollectionState copyWith({
    RequestState? requestState,
    String? errorMessage,
    List<FlashcardCollection>? collections,
  }) {
    return CollectionState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
      collections: collections ?? this.collections,
    );
  }

  @override
  List<Object> get props => [requestState, errorMessage, collections];
}
