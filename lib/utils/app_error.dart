import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:git_repos_search/utils/connection_utils.dart';

Future<T> execute<T>(Future<T> Function() apiCall) async {
  final bool isConnected = await ConnectionUtils.isConnected();
  if (isConnected) {
    try {
      return apiCall.call().catchError((Object e, StackTrace stackTrace) {
        throw _handleError(e);
      });
    } catch (e) {
      throw _handleError(e);
    }
  } else {
    throw ConnectionException();
  }
}

AppError _handleError(e) {
  if (e is DioError) {
    throw _handleDioError(e);
  } else if (e is SocketException || e is TimeoutException) {
    throw ConnectionException();
  } else if (e is HttpException) {
    if (e.message
        .startsWith('Connection closed before full header was received')) {
      throw ConnectionException();
    }
    throw UnknownException();
  } else {
    throw UnknownException();
  }
}

AppError _handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return ConnectionException();
    case DioErrorType.cancel:
      return SilentException();
    case DioErrorType.response:
    case DioErrorType.other:
    default:
      if (error.error is SocketException ||
          error.error is TimeoutException ||
          error.message.startsWith(
              'SocketException: OS Error: Network is unreachable')) {
        return ConnectionException();
      } else if (error.response?.statusCode == 401) {
        return UnauthorizedException();
      } else if (error.response?.statusCode == 404) {
        return NotFoundException();
      }
      return UnknownException();
  }
}

abstract class AppError implements Exception {
  abstract String message;
}

class ConnectionException extends AppError {
  @override
  String message = 'Cannot connect to server.';
}

class SilentException extends AppError {
  @override
  String message = 'The request was cancelled.';
}

class UnauthorizedException extends AppError {
  @override
  String message = 'You need to sign in before continuing.';
}

class NotFoundException extends AppError {
  @override
  String message = 'Please enter you pin code.';
}

class UnknownException extends AppError {
  @override
  String message = 'Something went wrong.';
}