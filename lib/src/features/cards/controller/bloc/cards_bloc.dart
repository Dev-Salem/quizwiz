import 'package:equatable/equatable.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/bloc/cards_events.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvents, CardsState> {
  final BaseCardsRepository _baseCardsRepository;
  final Isar _isar;

  CardsBloc(this._isar, this._baseCardsRepository) : super(const CardsState()) {
    on<GetCollectionsEvent>(_getCollections);
    on<RemoveCollectionEvent>(_removeCollection);
    on<CreateCollectionsEvent>(_createCollections);
    on<AddFlashcardsEvent>(_addFlashcards);
    on<RemoveFlashcardsEvent>(_removeFlashcard);
    on<UpdateDueTimeEvent>(_updateDueTime);
    on<EditFlashcardsEvent>(_editFlashcards);
    on<GetDueReviewsEvent>(_getDueReviewsEvent);
    on<EditCollectionEvent>(_editCollection);
    on<GetMultipleQuizOptionsEvent>(_getMultipleQuizOptionsEvent);
    on<GenerateFlashcardsEvent>(_generateFlashcards);
    on<SaveAllGenerateFlashcardsEvent>(_saveAllGenerateFlashcards);
    on<CombineCollectionsEvent>(_combineCollections);
    _isar.flashcardCollections.watchLazy().listen((event) {
      add(const GetCollectionsEvent());
    });
  }
  @override
  Future<void> close() async {
    await _isar.close();
    return super.close();
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
    add(const GetCollectionsEvent());
  }

  _addFlashcards(AddFlashcardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.addFlashcard(
        event.question, event.answer, event.collectionUuid);
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
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.removeFlashcard(
        event.collection, event.flashcardUuid);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)), (r) {
      emit(state.copyWith(
        collectionsRequestState: RequestState.success,
      ));
    });
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
              flashcardRequestState: RequestState.success,
            )));
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

  _getMultipleQuizOptionsEvent(
      GetMultipleQuizOptionsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(quizRequestState: RequestState.loading));
    final result =
        await _baseCardsRepository.getMultipleChoiceOptions(event.collection);
    result.fold(
        (l) => emit(state.copyWith(
            quizRequestState: RequestState.error, quizErrorMessage: l.message)),
        (r) => emit(state.copyWith(
            quizRequestState: RequestState.success,
            collectionsRequestState: RequestState.success,
            multipleChoices: r)));
  }

  _generateFlashcards(
      GenerateFlashcardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(flashcardRequestState: RequestState.loading));
    final result = await _baseCardsRepository.generateFlashcards(event.file);
    result.fold(
        (l) => emit(state.copyWith(
            flashcardRequestState: RequestState.error,
            flashcardErrorMessage: l.message)),
        (r) => emit(state.copyWith(
            flashcardRequestState: RequestState.success,
            collectionsRequestState: RequestState.success,
            flashcards: r)));
  }

  _saveAllGenerateFlashcards(
      SaveAllGenerateFlashcardsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.saveAllGeneratedFlashcard(
        event.collectionUuid, event.flashcards);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
  }

  _combineCollections(
      CombineCollectionsEvent event, Emitter<CardsState> emit) async {
    emit(state.copyWith(collectionsRequestState: RequestState.loading));
    final result = await _baseCardsRepository.combineCollections(
        event.mainCollection, event.secondaryCollection);
    result.fold(
        (l) => emit(state.copyWith(
            collectionsErrorMessage: l.message,
            collectionsRequestState: RequestState.error)),
        (r) => emit(state.copyWith(
              collectionsRequestState: RequestState.success,
            )));
  }
}
