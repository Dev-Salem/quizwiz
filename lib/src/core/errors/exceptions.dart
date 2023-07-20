// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocalStorageException implements Exception {
  final String message;

  const LocalStorageException({
    required this.message,
  });

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);

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
