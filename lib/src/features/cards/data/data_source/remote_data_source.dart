import 'package:quizwiz/src/core/core.dart';

abstract class BaseLocalDataSource {
  void generateFlashcards(String material);
}

class DioLocalDataSource extends BaseLocalDataSource {
  @override
  Future<void> generateFlashcards(String material) async {}

  void asa() {
    """
{
  text: [
        {
          "term": "Designing object-oriented software",
          "definition": "The process of creating software using object-oriented principles and techniques."
        },
        {
          "term": "Reusable object-oriented software",
          "definition": "Software that is designed to be easily reusable in different applications."
        },
        {
          "term": "Pertinent objects",
          "definition": "Objects that are relevant and necessary for solving a specific problem."
        },
        {
          "term": "Classes",
          "definition": "Structures that define objects and their behavior in object-oriented programming."
        },
        {
          "term": "Granularity",
          "definition": "Determining the appropriate level of detail or size for classes and objects."
        },
        {
          "term": "Class interfaces",
          "definition": "The public methods and properties that define how a class can be used by other classes or objects."
        },
        {
          "term": "Inheritance hierarchies",
          "definition": "The arrangement of classes in a hierarchical order, where subclasses inherit properties and behavior from superclasses."
        },
        {
          "term": "Key relationships",
          "definition": "The associations and dependencies between objects that are crucial for the functionality of the software."
        },
        {
          "term": "Redesign",
          "definition": "Modifying the existing design of software to improve its functionality, solve issues, or accommodate new requirements."
        },
        {
          "term": "Reusable and flexible design",
          "definition": "A design that allows for easy adaptation, extension, and reuse of software components."
        }
      ], finish_reason: stop, model: gpt-3.5-turbo-030}
      """;
  }
}
