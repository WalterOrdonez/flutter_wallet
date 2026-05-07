class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Cache Error'});
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException({this.message = 'No Internet Connection'});
}

class UnknownException implements Exception {
  final String message;
  UnknownException({this.message = 'An unexpected error occurred'});
}
