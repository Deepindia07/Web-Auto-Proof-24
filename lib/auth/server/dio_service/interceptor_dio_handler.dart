import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

/// Error interceptor for common error handling
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('API Error: ${err.message}');
    debugPrint('Status Code: ${err.response?.statusCode}');
    debugPrint('Response Data: ${err.response?.data}');

    switch (err.response?.statusCode) {
      case 400:
        debugPrint('Bad Request');
        break;
      case 401:
        debugPrint('Unauthorized');
        break;
      case 403:
        debugPrint('Forbidden');
        break;
      case 404:
        debugPrint('Not Found');
        break;
      case 500:
        debugPrint('Internal Server Error');
        break;
      default:
        debugPrint('Error: ${err.response?.statusCode}');
    }

    super.onError(err, handler);
  }
}


/// Auth interceptor to handle token refresh
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      debugPrint('Unauthorized - implement token refresh logic');
    }
    super.onError(err, handler);
  }
}

