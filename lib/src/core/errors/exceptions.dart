// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocalStorageException implements Exception {
  final String message;

  const LocalStorageException({
    required this.message,
  });

  @override
  String toString() => message;
}

class NetworkingException implements Exception {
  final String message;
  const NetworkingException(this.message);

  @override
  String toString() => message;
}

class JsonDeserializationException implements Exception {
  final String message;
  const JsonDeserializationException(this.message);
  @override
  String toString() => message;
}

class UnexpectedNetworkException implements Exception {
  final String message;
  const UnexpectedNetworkException(this.message);
  @override
  String toString() => message;
}

class PickingFileException {
  final String message;
  const PickingFileException(
      {this.message = "Invalid File: Pick a PDF or an Image"});
  @override
  String toString() => message;
}
