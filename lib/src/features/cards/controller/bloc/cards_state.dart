// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cards_bloc.dart';

class CardsState extends Equatable {
  //state of all the collections
  final RequestState collectionsRequestState;
  final String collectionsErrorMessage;
  final List<FlashcardCollection> collections;

  //state of flashcards of a specific collection
  final RequestState flashcardRequestState;
  final String flashcardErrorMessage;
  final List<Flashcard> flashcards;

  //state of [MultipleChoiceQuiz]
  final RequestState quizRequestState;
  final String quizErrorMessage;
  final List<MultipleChoiceQuiz> multipleChoices;

  const CardsState({
    this.collectionsRequestState = RequestState.loading,
    this.collectionsErrorMessage = '',
    this.collections = const [],
    this.flashcardRequestState = RequestState.loading,
    this.flashcardErrorMessage = '',
    this.flashcards = const [],
    this.quizRequestState = RequestState.loading,
    this.quizErrorMessage = '',
    this.multipleChoices = const [],
  });

  @override
  List<Object> get props {
    return [
      collectionsRequestState,
      collectionsErrorMessage,
      collections,
      flashcardRequestState,
      flashcardErrorMessage,
      flashcards,
      quizRequestState,
      quizErrorMessage,
      multipleChoices,
    ];
  }

  CardsState copyWith({
    RequestState? collectionsRequestState,
    String? collectionsErrorMessage,
    List<FlashcardCollection>? collections,
    RequestState? flashcardRequestState,
    String? flashcardErrorMessage,
    List<Flashcard>? flashcards,
    RequestState? quizRequestState,
    String? quizErrorMessage,
    List<MultipleChoiceQuiz>? multipleChoices,
  }) {
    return CardsState(
      collectionsRequestState:
          collectionsRequestState ?? this.collectionsRequestState,
      collectionsErrorMessage:
          collectionsErrorMessage ?? this.collectionsErrorMessage,
      collections: collections ?? this.collections,
      flashcardRequestState:
          flashcardRequestState ?? this.flashcardRequestState,
      flashcardErrorMessage:
          flashcardErrorMessage ?? this.flashcardErrorMessage,
      flashcards: flashcards ?? this.flashcards,
      quizRequestState: quizRequestState ?? this.quizRequestState,
      quizErrorMessage: quizErrorMessage ?? this.quizErrorMessage,
      multipleChoices: multipleChoices ?? this.multipleChoices,
    );
  }
}
