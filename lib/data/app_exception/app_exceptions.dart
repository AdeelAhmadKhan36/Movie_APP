class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class FetchDataException extends AppException {
  FetchDataException(String message) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException(String message) : super(message);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException(String message) : super(message);
}
