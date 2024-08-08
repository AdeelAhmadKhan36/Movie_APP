class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class FetchDataException extends AppException {
  FetchDataException(super.message);
}

class BadRequestException extends AppException {
  BadRequestException(super.message);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException(super.message);
}
