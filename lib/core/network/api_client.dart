import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bam_wallet_transfers/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiClient({
    required this.baseUrl,
    Dio? dio,
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               headers: defaultHeaders,
               connectTimeout: const Duration(seconds: 10),
               sendTimeout: const Duration(seconds: 10),
               receiveTimeout: const Duration(seconds: 10),
             ),
           );

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {...defaultHeaders, ...?headers}),
      );

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {...defaultHeaders, ...?headers}),
      );

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {...defaultHeaders, ...?headers}),
      );

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {...defaultHeaders, ...?headers}),
      );

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleResponse(Response<dynamic> response) {
    final data = response.data;
    if (data == null) {
      return null;
    }

    if (data is String && data.isNotEmpty) {
      try {
        return jsonDecode(data);
      } catch (_) {
        return data;
      }
    }

    return data;
  }

  Exception _handleError(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is SocketException) {
      return NoInternetException(message: 'Lost connection');
    } else if (error is TimeoutException) {
      return ServerException(message: 'Connection timeout to API');
    } else if (error is ServerException ||
        error is NoInternetException ||
        error is UnknownException) {
      return error as Exception;
    } else {
      return UnknownException(message: 'Uncontrolled error: $error');
    }
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException(message: 'Connection timeout to API');
      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return NoInternetException(message: 'Lost connection');
        }
        return ServerException(message: 'Connection error to API');
      case DioExceptionType.badResponse:
        return _handleBadResponseError(error.response);
      case DioExceptionType.cancel:
        return ServerException(message: 'Request was cancelled');
      case DioExceptionType.badCertificate:
        return ServerException(message: 'Bad SSL certificate');
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NoInternetException(message: 'Lost connection');
        }
        return UnknownException(message: 'Uncontrolled error: $error');
    }
  }

  Exception _handleBadResponseError(Response<dynamic>? response) {
    final int statusCode = response?.statusCode ?? 500;
    String message = 'Server Error: $statusCode';

    try {
      final dynamic body = response?.data;
      if (body is Map<String, dynamic>) {
        if (body.containsKey('message')) {
          message = body['message'].toString();
        } else if (body.containsKey('error')) {
          message = body['error'].toString();
        }
      } else if (body is String && body.isNotEmpty) {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('message')) {
            message = decoded['message'].toString();
          } else if (decoded.containsKey('error')) {
            message = decoded['error'].toString();
          } else {
            message = body;
          }
        } else {
          message = body;
        }
      }
    } catch (_) {
      // Body is not JSON, use default message
    }

    switch (statusCode) {
      case 400:
        return ServerException(
          message: message,
          statusCode: 400,
        ); // Bad Request
      case 401:
        return ServerException(
          message: message,
          statusCode: 401,
        ); // Unauthorized
      case 403:
        return ServerException(message: message, statusCode: 403); // Forbidden
      case 404:
        return ServerException(message: message, statusCode: 404); // Not Found
      case 500:
        return ServerException(
          message: message,
          statusCode: 500,
        ); // Internal Server Error
      case 502:
        return ServerException(message: 'Bad Gateway', statusCode: 502);
      case 503:
        return ServerException(message: 'Service Unavailable', statusCode: 503);
      default:
        return ServerException(message: message, statusCode: statusCode);
    }
  }
}
