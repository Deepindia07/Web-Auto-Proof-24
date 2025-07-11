import 'package:dio/dio.dart';

/// Exception Handler

class Result<T, E> {
  final T? _data;
  final E? _error;
  final bool _isSuccess;

  const Result._(this._data, this._error, this._isSuccess);

  factory Result.success(T data) => Result._(data, null, true);
  factory Result.failure(E error) => Result._(null, error, false);

  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;

  T get data {
    if (_isSuccess) return _data!;
    throw Exception('Called data on failure result');
  }

  E get error {
    if (!_isSuccess) return _error!;
    throw Exception('Called error on success result');
  }

  T? get dataOrNull => _data;
  E? get errorOrNull => _error;
}

/// handle dio specific errors
Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.connectionTimeout:
      return Exception('Connection timeout. Please check your internet connection.');
    case DioExceptionType.sendTimeout:
      return Exception('Request timeout. Please try again.');
    case DioExceptionType.receiveTimeout:
      return Exception('Server response timeout. Please try again.');
    case DioExceptionType.badResponse:
      final statusCode = dioError.response?.statusCode;
      final message = dioError.response?.data?['message'] ?? 'Unknown error';
      return Exception('Server error ($statusCode): $message');
    case DioExceptionType.cancel:
      return Exception('Request cancelled.');
    case DioExceptionType.connectionError:
      return Exception('No internet connection. Please check your network.');
    default:
      return Exception('Network error: ${dioError.message}');
  }
}

String getDioErrorMessage(DioException dioError) {  /*deep07developer1@gmail.com    123456*/
  switch (dioError.type) {
    case DioExceptionType.connectionTimeout:
      return 'Connection timeout. Please check your internet connection.';
    case DioExceptionType.sendTimeout:
      return 'Request timeout. Please try again.';
    case DioExceptionType.receiveTimeout:
      return 'Server response timeout. Please try again.';
    case DioExceptionType.badResponse:
      final statusCode = dioError.response?.statusCode;
      final message = dioError.response?.data?['message'] ?? 'Unknown error';
      return 'Server error ($statusCode): $message';
    case DioExceptionType.cancel:
      return 'Request cancelled.';
    case DioExceptionType.connectionError:
      return 'No internet connection. Please check your network.';
    default:
      return 'Network error: ${dioError.message}';
  }
}
