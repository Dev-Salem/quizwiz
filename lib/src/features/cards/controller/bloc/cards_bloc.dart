import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/bloc/cards_events.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizwiz/src/features/cards/data/repository/cards_repository.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvents, CardsState> {
  final CardsRepository _baseCardsRepository;
  final collectionStream = Isar.getInstance()!.flashcardCollections.watchLazy();

  CardsBloc(this._baseCardsRepository) : super(const CardsState()) {
    on<GetCollectionsEvent>(_getCollections);
    on<RemoveCollectionEvent>(_removeCollection);
    on<CreateCollectionsEvent>(_createCollections);
    on<AddFlashcardsEvent>(_addFlashcards);
    on<RemoveFlashcardsEvent>(_removeFlashcard);
    on<UpdateDueTimeEvent>(_updateDueTime);
    on<EditFlashcardsEvent>(_editFlashcards);
    on<GetDueReviewsEvent>(_getDueReviewsEvent);
    on<EditCollectionEvent>(_editCollection);
    on<GetCollectionEvent>(_getCollection);
    collectionStream.listen((event) {
      add(GetCollectionsEvent());
    });
  }

  _getCollections(GetCollectionsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.getCollections();
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
            collectionsRequestState: RequestState.success, collections: r)));
  }

  _removeCollection(
      RemoveCollectionEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.removeCollection(event.uuid);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
  }

  _createCollections(
      CreateCollectionsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.createCollection(event.name,
        description: event.description);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
  }

  _addFlashcards(AddFlashcardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.addFlashcard(
        event.front, event.back, event.collectionUuid);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
  }

  _updateDueTime(UpdateDueTimeEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.updateDueTime(
        event.card, event.collectionUuid, event.reviewResult);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
  }

  _removeFlashcard(
      RemoveFlashcardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionRequestState: RequestState.loading));
    final result = await _baseCardsRepository.removeFlashcard(
        event.collection, event.flashcardUuid);
    result.fold(
        (l) => emit(state.copyWith(
            collectionErrorMessage: l.message,
            collectionRequestState: RequestState.error)), (r) {
      emit(state.copyWith(
        collectionRequestState: RequestState.success,
      ));
    });
    add(GetCollectionEvent(collectionUuid: event.collection.uuid));
  }

  _editFlashcards(EditFlashcardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.editFlashcard(event.parameters);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
    add(GetCollectionEvent(collectionUuid: event.parameters.collection.uuid));
  }

  _getDueReviewsEvent(
      GetDueReviewsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result =
        await _baseCardsRepository.getDueReviewCards(event.collection);
    result.fold(
        (l) => emit(state.copyWith(
            flashcardErrorMessage: l.message,
            flashcardRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
            collectionsRequestState: RequestState.success,
            flashcards: r,
            flashcardRequestState: RequestState.success)));
  }

  _editCollection(EditCollectionEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.editCollection((
      collection: event.collection,
      name: event.name,
      description: event.description
    ));
    result.fold((l) {
      emit(state.copyWith(
          collectionsErrorMessage: l.message,
          collectionsRequestState: RequestState.error));
    }, (r) {
      emit(state.copyWith(
        collectionsRequestState: RequestState.success,
      ));
    });
  }

  _getCollection(GetCollectionEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionRequestState: RequestState.loading));
    final result =
        await _baseCardsRepository.getCollection(event.collectionUuid);
    result.fold(
        (l) => emit(state.copyWith(
            collectionErrorMessage: l.message,
            collectionRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              collection: r,
            )));
  }
}
