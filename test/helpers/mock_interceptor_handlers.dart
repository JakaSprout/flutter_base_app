import 'package:dio/dio.dart';

/// Mock error interceptor handler that doesn't throw when next() is called.
class MockErrorInterceptorHandler extends ErrorInterceptorHandler {
  @override
  void next(DioException err) {
    // Do nothing - don't call super.next() to avoid throwing in test context
  }

  @override
  void resolve(
    Response<dynamic> response, [
    bool callFollowingResponseInterceptor = true,
  ]) {
    // Do nothing - don't call super.resolve() to avoid throwing in test context
  }

  @override
  void reject(DioException err, [bool callFollowingErrorInterceptor = true]) {
    // Do nothing - don't call super.reject() to avoid throwing in test context
  }
}

/// Mock request interceptor handler that doesn't throw when next() is called.
class MockRequestInterceptorHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions options) {
    // Do nothing - don't call super.next() to avoid throwing in test context
  }

  @override
  void resolve(
    Response<dynamic> response, [
    bool callFollowingResponseInterceptor = true,
  ]) {
    // Do nothing - don't call super.resolve() to avoid throwing in test context
  }

  @override
  void reject(DioException err, [bool callFollowingErrorInterceptor = true]) {
    // Do nothing - don't call super.reject() to avoid throwing in test context
  }
}

/// Mock response interceptor handler that doesn't throw when next() is called.
class MockResponseInterceptorHandler extends ResponseInterceptorHandler {
  @override
  void next(Response<dynamic> response) {
    // Do nothing - don't call super.next() to avoid throwing in test context
  }

  @override
  void resolve(
    Response<dynamic> response, [
    bool callFollowingResponseInterceptor = true,
  ]) {
    // Do nothing - don't call super.resolve() to avoid throwing in test context
  }

  @override
  void reject(DioException err, [bool callFollowingErrorInterceptor = true]) {
    // Do nothing - don't call super.reject() to avoid throwing in test context
  }
}
