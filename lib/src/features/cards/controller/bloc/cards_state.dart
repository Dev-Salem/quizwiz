// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cards_bloc.dart';

class CardsState extends Equatable {
  //state of all the collections
  final RequestState collectionsRequestState;
  final String collectionsErrorMessage;
  final List<FlashcardCollection> collections;

  //state of a single collection
  final RequestState collectionRequestState;
  final String collectionErrorMessage;
  final FlashcardCollection? collection;

  //state of flashcards of a specific collection
  final RequestState flashcardRequestState;
  final String flashcardErrorMessage;
  final List<Flashcard> flashcards;

  const CardsState({
    this.collectionsRequestState = RequestState.loading,
    this.collectionsErrorMessage = '',
    this.collections = const [],
    this.collectionRequestState = RequestState.loading,
    this.collectionErrorMessage = '',
    this.collection,
    this.flashcardRequestState = RequestState.loading,
    this.flashcardErrorMessage = '',
    this.flashcards = const [],
  });

  @override
  List<Object> get props {
    return [
      collectionsRequestState,
      collectionsErrorMessage,
      collections,
      collectionRequestState,
      collectionErrorMessage,
      flashcardRequestState,
      flashcardErrorMessage,
      flashcards,
    ];
  }

  CardsState copyWith({
    RequestState? collectionsRequestState,
    String? collectionsErrorMessage,
    List<FlashcardCollection>? collections,
    RequestState? collectionRequestState,
    String? collectionErrorMessage,
    FlashcardCollection? collection,
    RequestState? flashcardRequestState,
    String? flashcardErrorMessage,
    List<Flashcard>? flashcards,
  }) {
    return CardsState(
      collectionsRequestState:
          collectionsRequestState ?? this.collectionsRequestState,
      collectionsErrorMessage:
          collectionsErrorMessage ?? this.collectionsErrorMessage,
      collections: collections ?? this.collections,
      collectionRequestState:
          collectionRequestState ?? this.collectionRequestState,
      collectionErrorMessage:
          collectionErrorMessage ?? this.collectionErrorMessage,
      collection: collection ?? this.collection,
      flashcardRequestState:
          flashcardRequestState ?? this.flashcardRequestState,
      flashcardErrorMessage:
          flashcardErrorMessage ?? this.flashcardErrorMessage,
      flashcards: flashcards ?? this.flashcards,
    );
  }
}