import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/cubit/cards_events.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizwiz/src/features/cards/data/repository/cards_repository.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvents, CollectionState> {
  final CardsRepository _baseCardsRepository;
  final collectionStream = Isar.getInstance()!.flashcardCollections.watchLazy();

  CardsBloc(this._baseCardsRepository) : super(const CollectionState()) {
    on<GetCollectionsEvent>(_getCollections);
    on<RemoveCollectionEvent>(_removeCollection);
    on<CreateCollectionsEvent>(_createCollections);
    on<AddFlashcardsEvent>(_addFlashcards);
    collectionStream.listen((event) {
      add(GetCollectionsEvent());
    });
  }

  _getCollections(
      GetCollectionsEvent event, Emitter<CollectionState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _baseCardsRepository.getCollections();
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, requestState: RequestState.error)),
        (r) => emit(state.copyWith(
            requestState: RequestState.success, collections: r)));
  }

  _removeCollection(
      RemoveCollectionEvent event, Emitter<CollectionState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _baseCardsRepository.removeCollection(event.uuid);
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, requestState: RequestState.error)),
        (r) => emit(state.copyWith(
              requestState: RequestState.success,
            )));
  }

  _createCollections(
      CreateCollectionsEvent event, Emitter<CollectionState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _baseCardsRepository.createCollection(event.name,
        description: event.description);
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, requestState: RequestState.error)),
        (r) => emit(state.copyWith(
              requestState: RequestState.success,
            )));
  }

  _addFlashcards(
      AddFlashcardsEvent event, Emitter<CollectionState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _baseCardsRepository.addFlashcard(
        event.front, event.back, event.collectionUuid);
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message, requestState: RequestState.error)),
        (r) => emit(state.copyWith(
              requestState: RequestState.success,
            )));
  }
}
