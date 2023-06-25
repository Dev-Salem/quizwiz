// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class CardsEvents extends Equatable {
  const CardsEvents();
  @override
  List<Object?> get props => [];
}

class GetCollectionsEvent extends CardsEvents {
  @override
  List<Object?> get props => [];
}

class RemoveCollectionEvent extends CardsEvents {
  final String uuid;
  const RemoveCollectionEvent({
    required this.uuid,
  });
  @override
  List<Object?> get props => [uuid];
}

class CreateCollectionsEvent extends CardsEvents {
  final String name;
  final String description;
  const CreateCollectionsEvent({
    required this.name,
    required this.description,
  });
}

class AddFlashcardsEvent extends CardsEvents {
  final String collectionUuid;
  final String front;
  final String back;
  const AddFlashcardsEvent({
    required this.collectionUuid,
    required this.front,
    required this.back,
  });
}
