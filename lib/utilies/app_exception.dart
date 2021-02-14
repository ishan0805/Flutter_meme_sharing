class AppException implements Exception {
  final message;

  AppException({this.message});

  String toString() {
    return "$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message: 'Please check your network connection');
}

class BadRequestException extends AppException {
  BadRequestException([String message]) : super(message: message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String message]) : super(message: message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message: message);
}
