import 'dart:developer';
import 'dart:io';

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/constants/const_api_endpoints.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'interceptor_dio_handler.dart';
// import 'log_interceptor.dart'as LogInterceptor;

String setContentType() {
  return "application/json";
}

class DioClient {
  // Using singleton pattern for DioClient
  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  late Dio _dio;

  Dio get dio => _dio;

  DioClient._internal() {
    _dio = Dio();
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = ApiEndPoints.baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: 30000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    _dio.options.contentType = setContentType();
    _dio.options.headers = {
      "Content-Type": setContentType(),
    };

    if (kDebugMode) {
      _dio.interceptors.add(ErrorInterceptor());
      _dio.interceptors.add(AuthInterceptor());
    }

    // if (kDebugMode) {
    //   _dio.interceptors.add(LogInterceptor.LogInterceptor(
    //     responseBody: true,
    //     request: true,
    //     requestHeader: true,
    //     responseHeader: false,
    //     requestBody: true,
    //     error: true,
    //   ));
    // }

    if (!kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) {
          return true;
        };
        return client;
      };
    }
  }

  /// Helper method to get authorization headers
  Map<String, dynamic> _getAuthHeaders() {
    final token = SharedPrefsHelper.instance.getString(localToken);
    log("token------$token");
    return token != null ? {'Authorization': 'Bearer $token'} : {};
  }

  /// Helper method to merge headers with auth headers
  Options _mergeOptionsWithAuth(Options? options) {
    final authHeaders = _getAuthHeaders();

    if (options == null) {
      return Options(headers: authHeaders);
    }

    final mergedHeaders = <String, dynamic>{
      ...authHeaders,
      ...?options.headers,
    };

    return options.copyWith(headers: mergedHeaders);
  }

  /// [Get]
  Future<Response<dynamic>> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        dynamic data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      debugPrint("🔹 Sending GET to ${ApiEndPoints.baseUrl}$url");
      final response = await _dio.get(
        "${ApiEndPoints.baseUrl}$url",
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        options: _mergeOptionsWithAuth(options),
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// [POST]
  Future<dynamic> post(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      debugPrint("🔹 Sending post to ${ApiEndPoints.baseUrl}$url");
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: _mergeOptionsWithAuth(options),
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// [PUT]
  Future<dynamic> put(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      debugPrint("🔹 Sending PUT to ${ApiEndPoints.baseUrl}$url");
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: _mergeOptionsWithAuth(options),
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// [Delete]
  Future<dynamic> delete(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      debugPrint("🔹 Sending delete to ${ApiEndPoints.baseUrl}$url");
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: _mergeOptionsWithAuth(options),
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// [PATCH]
  Future<dynamic> patch(
      String url, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: _mergeOptionsWithAuth(options),
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// Method to update token (useful for refreshing tokens)
  void updateToken(String newToken) {
    SharedPrefsHelper.instance.setString(localToken, newToken);
  }

  /// Method to clear token (useful for logout)
  void clearToken() {
    SharedPrefsHelper.instance.remove(localToken);
  }

  /// Method to check if user is authenticated
  bool get isAuthenticated {
    final token = SharedPrefsHelper.instance.getString(localToken);
    return token != null && token.isNotEmpty;
  }
}