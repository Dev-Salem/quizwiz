// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cards_bloc.dart';

class CardsState extends Equatable {
  final RequestState collectionRequestState;
  final String collectionErrorMessage;
  final List<FlashcardCollection> collections;

  final RequestState flashcardRequestState;
  final String flashcardErrorMessage;
  final List<Flashcard> flashcards;
  const CardsState({
    this.collectionRequestState = RequestState.loading,
    this.collectionErrorMessage = '',
    this.collections = const [],
    this.flashcardRequestState = RequestState.loading,
    this.flashcardErrorMessage = '',
    this.flashcards = const [],
  });

  @override
  List<Object> get props {
    return [
      collectionRequestState,
      collectionErrorMessage,
      collections,
      flashcardRequestState,
      flashcardErrorMessage,
      flashcards,
    ];
  }

  CardsState copyWith({
    RequestState? collectionRequestState,
    String? collectionErrorMessage,
    List<FlashcardCollection>? collections,
    RequestState? flashcardRequestState,
    String? flashcardErrorMessage,
    List<Flashcard>? flashcards,
  }) {
    return CardsState(
      collectionRequestState:
          collectionRequestState ?? this.collectionRequestState,
      collectionErrorMessage:
          collectionErrorMessage ?? this.collectionErrorMessage,
      collections: collections ?? this.collections,
      flashcardRequestState:
          flashcardRequestState ?? this.flashcardRequestState,
      flashcardErrorMessage:
          flashcardErrorMessage ?? this.flashcardErrorMessage,
      flashcards: flashcards ?? this.flashcards,
    );
  }
}
