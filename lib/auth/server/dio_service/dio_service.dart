import 'dart:io';

import 'package:auto_proof/constants/const_api_endpoints.dart';
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
  static final DioClient _instance = DioClient._internal(); ///   Using singleton pattern for DioClient

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

    if(kDebugMode){
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

  /// [Get]
  Future<Response<dynamic>> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
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
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
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
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
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
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
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
        options: options,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
