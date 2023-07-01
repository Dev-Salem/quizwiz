// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocalStorageException implements Exception {
  final String message;

  const LocalStorageException({
    required this.message,
  });
}

class NetworkingException implements Exception {
  final String message;
  const NetworkingException(this.message);
}
