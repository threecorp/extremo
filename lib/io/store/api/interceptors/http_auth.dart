import 'package:dio/dio.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/misc/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HttpAuthInterceptor extends QueuedInterceptor {
  HttpAuthInterceptor(this.dio, this.ref);
  final Dio dio;
  final Ref ref;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authHeader = options.headers['Authorization'];
    if (authHeader == null || (authHeader is String && authHeader.isEmpty)) {
      final token = ref.read(accountProvider.notifier).token() ?? '';
      options.headers['Authorization'] = 'Bearer $token'; // XXX: watch?
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // TODO(refactoring): If expired,
    // force renewal and retry
    // Condition is determined by status code (tentative)
    //
    // if (err.response?.statusCode == 401) {
    //   final newAccessToken = await getRefreshToken();
    //   err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
    //   final response = await dio.fetch(err.requestOptions);
    //   return handler.resolve(response);
    // }
    return handler.next(err);
  }
}
